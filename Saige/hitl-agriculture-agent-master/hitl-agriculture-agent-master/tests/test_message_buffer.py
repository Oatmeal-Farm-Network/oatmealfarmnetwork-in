# --- tests/test_message_buffer.py --- (Task 6: Unit tests for MessageBuffer)
"""
Unit tests for the Redis-backed MessageBuffer.
Covers:
  - push + trim to last-N
  - oldest-to-newest ordering
  - TTL is applied
  - concurrent pushes don't corrupt the buffer
  - content truncation & metadata filtering (Task 5 safety)
  - observability counters (Task 6)
"""
import json
import time
import uuid
import threading
import pytest


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
def _msg(role="user", content="hello", **extra):
    """Shortcut to build a message dict."""
    m = {"role": role, "content": content, "message_id": str(uuid.uuid4())}
    m.update(extra)
    return m


# ---------------------------------------------------------------------------
# 1. Push + Trim + Ordering
# ---------------------------------------------------------------------------
class TestPushTrimOrder:
    """Verify LPUSH + LTRIM + reverse-read gives correct last-N ordering."""

    def test_push_single_message(self, make_buffer):
        buf = make_buffer(buffer_size=5)
        tid = f"test_push_single_{uuid.uuid4().hex[:8]}"
        assert buf.push_message(tid, _msg(content="first"))
        msgs = buf.get_last_n(tid)
        assert len(msgs) == 1
        assert msgs[0]["content"] == "first"

    def test_ordering_oldest_to_newest(self, make_buffer):
        buf = make_buffer(buffer_size=10)
        tid = f"test_order_{uuid.uuid4().hex[:8]}"
        for i in range(5):
            buf.push_message(tid, _msg(content=f"msg-{i}"))
        msgs = buf.get_last_n(tid)
        assert [m["content"] for m in msgs] == [f"msg-{i}" for i in range(5)]

    def test_trim_to_buffer_size(self, make_buffer):
        buf = make_buffer(buffer_size=3)
        tid = f"test_trim_{uuid.uuid4().hex[:8]}"
        for i in range(7):
            buf.push_message(tid, _msg(content=f"msg-{i}"))
        msgs = buf.get_last_n(tid)
        # Only the last 3 should remain
        assert len(msgs) == 3
        assert [m["content"] for m in msgs] == ["msg-4", "msg-5", "msg-6"]

    def test_get_last_n_with_limit(self, make_buffer):
        buf = make_buffer(buffer_size=10)
        tid = f"test_limit_{uuid.uuid4().hex[:8]}"
        for i in range(5):
            buf.push_message(tid, _msg(content=f"msg-{i}"))
        msgs = buf.get_last_n(tid, n=2)
        # Should return only the 2 most recent, oldest first
        assert len(msgs) == 2
        assert msgs[0]["content"] == "msg-3"
        assert msgs[1]["content"] == "msg-4"

    def test_clear_thread(self, make_buffer):
        buf = make_buffer(buffer_size=5)
        tid = f"test_clear_{uuid.uuid4().hex[:8]}"
        buf.push_message(tid, _msg(content="a"))
        assert buf.get_message_count(tid) == 1
        assert buf.clear_thread(tid)
        assert buf.get_message_count(tid) == 0


# ---------------------------------------------------------------------------
# 2. TTL Behaviour
# ---------------------------------------------------------------------------
class TestTTL:
    """Verify that keys are assigned a TTL when ttl_seconds > 0."""

    def test_ttl_is_set(self, make_buffer, redis_client):
        buf = make_buffer(buffer_size=5, ttl_seconds=300)
        tid = f"test_ttl_{uuid.uuid4().hex[:8]}"
        buf.push_message(tid, _msg(content="ttl-test"))
        key = f"thread:{tid}:last_messages"
        ttl = redis_client.ttl(key)
        assert ttl > 0, f"Expected positive TTL, got {ttl}"
        assert ttl <= 300

    def test_no_ttl_when_zero(self, make_buffer, redis_client):
        buf = make_buffer(buffer_size=5, ttl_seconds=0)
        tid = f"test_no_ttl_{uuid.uuid4().hex[:8]}"
        buf.push_message(tid, _msg(content="no-ttl"))
        key = f"thread:{tid}:last_messages"
        ttl = redis_client.ttl(key)
        # -1 means key exists but has no associated expire
        assert ttl == -1, f"Expected no TTL (-1), got {ttl}"

    def test_short_ttl_expiry(self, make_buffer, redis_client):
        """Push a message with a 2-second TTL and verify it expires."""
        buf = make_buffer(buffer_size=5, ttl_seconds=2)
        tid = f"test_expire_{uuid.uuid4().hex[:8]}"
        buf.push_message(tid, _msg(content="vanish"))
        assert buf.get_message_count(tid) == 1
        time.sleep(3)
        assert buf.get_message_count(tid) == 0


# ---------------------------------------------------------------------------
# 3. Concurrent Push
# ---------------------------------------------------------------------------
class TestConcurrentPush:
    """Multiple threads pushing to the same buffer must not exceed buffer_size."""

    def test_concurrent_push_does_not_exceed_buffer(self, make_buffer):
        buf = make_buffer(buffer_size=5)
        tid = f"test_concurrent_{uuid.uuid4().hex[:8]}"
        num_threads = 10
        msgs_per_thread = 5

        def _push(thread_idx):
            for j in range(msgs_per_thread):
                buf.push_message(tid, _msg(content=f"t{thread_idx}-m{j}"))

        threads = [threading.Thread(target=_push, args=(i,)) for i in range(num_threads)]
        for t in threads:
            t.start()
        for t in threads:
            t.join()

        count = buf.get_message_count(tid)
        assert count <= 5, f"Buffer exceeded max size: {count}"
        msgs = buf.get_last_n(tid)
        assert len(msgs) <= 5


# ---------------------------------------------------------------------------
# 4. Content Truncation & Metadata Filtering (Task 5 safety via buffer)
# ---------------------------------------------------------------------------
class TestSafetyControls:
    """Verify that MessageBuffer._normalize_message enforces size/metadata limits."""

    def test_long_content_truncated(self, make_buffer):
        from config import MAX_STORED_CONTENT_CHARS

        buf = make_buffer(buffer_size=5)
        tid = f"test_trunc_{uuid.uuid4().hex[:8]}"
        long_text = "A" * (MAX_STORED_CONTENT_CHARS + 500)
        buf.push_message(tid, _msg(content=long_text))
        msgs = buf.get_last_n(tid)
        assert len(msgs) == 1
        assert msgs[0]["content"].endswith("...[truncated]")
        assert len(msgs[0]["content"]) <= MAX_STORED_CONTENT_CHARS + 20

    def test_metadata_whitelist(self, make_buffer):
        buf = make_buffer(buffer_size=5)
        tid = f"test_meta_wl_{uuid.uuid4().hex[:8]}"
        msg = _msg(content="meta", metadata={"type": "advisory", "evil_key": "dropped"})
        buf.push_message(tid, msg)
        msgs = buf.get_last_n(tid)
        meta = msgs[0].get("metadata", {})
        assert "type" in meta
        assert "evil_key" not in meta

    def test_non_dict_metadata_dropped(self, make_buffer):
        buf = make_buffer(buffer_size=5)
        tid = f"test_meta_bad_{uuid.uuid4().hex[:8]}"
        msg = _msg(content="meta", metadata="not-a-dict")
        buf.push_message(tid, msg)
        msgs = buf.get_last_n(tid)
        assert "metadata" not in msgs[0]


# ---------------------------------------------------------------------------
# 5. Observability Counters (Task 6)
# ---------------------------------------------------------------------------
class TestObservability:
    """Verify that ops_total / errors_total counters increment."""

    def test_ops_counter_increments(self, make_buffer):
        from message_buffer import MessageBuffer

        before = MessageBuffer._ops_total
        buf = make_buffer(buffer_size=5)
        tid = f"test_obs_{uuid.uuid4().hex[:8]}"
        buf.push_message(tid, _msg(content="obs"))
        buf.get_last_n(tid)
        after = MessageBuffer._ops_total
        assert after >= before + 2, f"Expected at least +2 ops, got {after - before}"

    def test_stats_method(self, make_buffer):
        from message_buffer import MessageBuffer

        stats = MessageBuffer.stats()
        assert "ops_total" in stats
        assert "errors_total" in stats

    def test_add_message_compat(self, make_buffer):
        """Backward-compat add_message wrapper also works."""
        buf = make_buffer(buffer_size=5)
        tid = f"test_compat_{uuid.uuid4().hex[:8]}"
        assert buf.add_message(tid, "user", "compat-msg")
        msgs = buf.get_messages(tid)
        assert len(msgs) == 1
        assert msgs[0]["content"] == "compat-msg"


# ---------------------------------------------------------------------------
# 6. Normalize edge cases
# ---------------------------------------------------------------------------
class TestNormalize:
    """Edge-case coverage for _normalize_message."""

    def test_missing_fields_get_defaults(self, make_buffer):
        buf = make_buffer(buffer_size=5)
        tid = f"test_defaults_{uuid.uuid4().hex[:8]}"
        buf.push_message(tid, {})  # completely empty message
        msgs = buf.get_last_n(tid)
        assert len(msgs) == 1
        assert msgs[0]["role"] == "assistant"
        assert "message_id" in msgs[0]
        assert "ts" in msgs[0]

    def test_empty_buffer_returns_empty_list(self, make_buffer):
        buf = make_buffer(buffer_size=5)
        tid = f"test_empty_{uuid.uuid4().hex[:8]}"
        assert buf.get_last_n(tid) == []

    def test_get_last_n_zero_returns_empty(self, make_buffer):
        buf = make_buffer(buffer_size=5)
        tid = f"test_zero_{uuid.uuid4().hex[:8]}"
        buf.push_message(tid, _msg(content="x"))
        assert buf.get_last_n(tid, n=0) == []

