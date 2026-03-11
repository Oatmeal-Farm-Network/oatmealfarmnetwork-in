"""
Unit tests for ChatHistory (Firestore-backed chat persistence).

All Firestore interactions are mocked — no real Firestore instance required.
"""
import datetime
from unittest.mock import MagicMock, patch, PropertyMock

import pytest

# ---------------------------------------------------------------------------
# We need to mock config + firestore imports *before* importing chat_history
# ---------------------------------------------------------------------------

# Patch config values used at import time
_config_patch = {
    "FIRESTORE_AVAILABLE": True,
    "FIRESTORE_DATABASE": "test-db",
    "GCP_CREDENTIALS": "",
    "GCP_PROJECT": "test-project",
    "THREADS_COLLECTION": "threads",
}


@pytest.fixture(autouse=True)
def _patch_config(monkeypatch):
    """Patch config values for every test."""
    import config as cfg

    for key, value in _config_patch.items():
        monkeypatch.setattr(cfg, key, value)


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_doc_snapshot(data: dict, exists: bool = True, doc_id: str = "doc1"):
    """Create a mock Firestore DocumentSnapshot."""
    snap = MagicMock()
    snap.exists = exists
    snap.to_dict.return_value = data if exists else None
    snap.id = doc_id
    snap.reference = MagicMock()
    return snap


def _make_chat_history():
    """Return a ChatHistory instance with a mocked Firestore client."""
    from chat_history import ChatHistory

    ch = ChatHistory()
    ch._db = MagicMock()  # bypass lazy init
    return ch


# ===================================================================
# save_message
# ===================================================================


class TestSaveMessage:
    """Tests for ChatHistory.save_message()."""

    def test_creates_thread_and_message_on_first_call(self):
        ch = _make_chat_history()
        threads_col = ch._db.collection.return_value
        thread_ref = threads_col.document.return_value

        # Thread does not exist yet
        thread_ref.get.return_value = _make_doc_snapshot({}, exists=False)

        # Messages subcollection
        msg_col = thread_ref.collection.return_value
        msg_doc = msg_col.document.return_value

        result = ch.save_message(
            user_id="user1",
            thread_id="t1",
            role="user",
            content="Hello world",
        )

        assert result is True

        # Thread doc should have been created via set()
        thread_ref.set.assert_called_once()
        set_data = thread_ref.set.call_args[0][0]
        assert set_data["thread_id"] == "t1"
        assert set_data["user_id"] == "user1"
        assert set_data["status"] == "active"
        assert set_data["message_count"] == 1
        assert set_data["preview"] == "Hello world"

        # Message doc should have been created
        msg_doc.set.assert_called_once()
        msg_data = msg_doc.set.call_args[0][0]
        assert msg_data["role"] == "user"
        assert msg_data["content"] == "Hello world"
        assert "ts" in msg_data

    def test_appends_to_existing_thread(self):
        ch = _make_chat_history()
        threads_col = ch._db.collection.return_value
        thread_ref = threads_col.document.return_value

        # Thread already exists
        thread_ref.get.return_value = _make_doc_snapshot(
            {"user_id": "user1", "preview": "first msg"}, exists=True
        )

        msg_col = thread_ref.collection.return_value
        msg_doc = msg_col.document.return_value

        result = ch.save_message(
            user_id="user1",
            thread_id="t1",
            role="assistant",
            content="Hi there!",
            metadata={"latency_ms": 120},
        )

        assert result is True

        # Thread doc should have been updated (not set)
        thread_ref.update.assert_called_once()
        update_data = thread_ref.update.call_args[0][0]
        assert "updated_at" in update_data

        # Message should include metadata
        msg_doc.set.assert_called_once()
        msg_data = msg_doc.set.call_args[0][0]
        assert msg_data["metadata"] == {"latency_ms": 120}

    def test_returns_false_when_firestore_unavailable(self):
        ch = _make_chat_history()
        ch._db = None  # simulate no Firestore

        result = ch.save_message("u", "t", "user", "msg")
        assert result is False

    def test_returns_false_on_firestore_exception(self):
        ch = _make_chat_history()
        ch._db.collection.side_effect = Exception("Firestore down")

        result = ch.save_message("u", "t", "user", "msg")
        assert result is False


# ===================================================================
# mark_complete
# ===================================================================


class TestMarkComplete:
    def test_updates_thread_status(self):
        ch = _make_chat_history()
        threads_col = ch._db.collection.return_value
        thread_ref = threads_col.document.return_value

        result = ch.mark_complete(
            user_id="u1",
            thread_id="t1",
            advisory_type="crops",
            farm_context={"location": "Hayward, CA"},
        )

        assert result is True
        thread_ref.update.assert_called_once()
        data = thread_ref.update.call_args[0][0]
        assert data["status"] == "complete"
        assert data["advisory_type"] == "crops"
        assert data["farm_context"] == {"location": "Hayward, CA"}

    def test_returns_false_on_error(self):
        ch = _make_chat_history()
        ch._db.collection.side_effect = Exception("boom")

        assert ch.mark_complete("u", "t") is False


# ===================================================================
# get_messages
# ===================================================================


class TestGetMessages:
    def _setup_thread_with_messages(self, ch, messages, user_id="user1"):
        """Wire up the mock chain for a thread with messages."""
        threads_col = ch._db.collection.return_value
        thread_ref = threads_col.document.return_value

        # Thread exists and belongs to user
        thread_ref.get.return_value = _make_doc_snapshot(
            {"user_id": user_id}, exists=True
        )

        # Messages subcollection query chain
        msg_col = thread_ref.collection.return_value
        query = msg_col.order_by.return_value
        query.limit.return_value = query  # .limit() returns self
        query.start_after.return_value = query  # .start_after() returns self

        # Stream returns mock docs
        msg_docs = []
        for m in messages:
            doc = MagicMock()
            doc.id = m.get("message_id", "m1")
            doc.to_dict.return_value = m
            msg_docs.append(doc)
        query.stream.return_value = iter(msg_docs)

        return query

    def test_returns_ordered_messages(self):
        ch = _make_chat_history()
        msgs_data = [
            {"role": "user", "content": "Hi", "ts": "2026-01-01T00:00:00", "metadata": None, "message_id": "m1"},
            {"role": "assistant", "content": "Hello", "ts": "2026-01-01T00:00:01", "metadata": None, "message_id": "m2"},
        ]
        self._setup_thread_with_messages(ch, msgs_data)

        messages, next_cursor = ch.get_messages("user1", "t1")

        assert len(messages) == 2
        assert messages[0]["role"] == "user"
        assert messages[1]["role"] == "assistant"
        assert next_cursor == "2026-01-01T00:00:01"

    def test_returns_empty_for_missing_thread(self):
        ch = _make_chat_history()
        threads_col = ch._db.collection.return_value
        thread_ref = threads_col.document.return_value
        thread_ref.get.return_value = _make_doc_snapshot({}, exists=False)

        messages, cursor = ch.get_messages("user1", "nonexistent")
        assert messages == []
        assert cursor is None

    def test_returns_empty_for_wrong_user(self):
        ch = _make_chat_history()
        threads_col = ch._db.collection.return_value
        thread_ref = threads_col.document.return_value
        thread_ref.get.return_value = _make_doc_snapshot(
            {"user_id": "other_user"}, exists=True
        )

        messages, cursor = ch.get_messages("user1", "t1")
        assert messages == []

    def test_pagination_cursor_passed_to_query(self):
        ch = _make_chat_history()
        query = self._setup_thread_with_messages(ch, [])

        ch.get_messages("user1", "t1", cursor="2026-01-01T00:00:00")

        query.start_after.assert_called_once_with({"ts": "2026-01-01T00:00:00"})


# ===================================================================
# get_threads
# ===================================================================


class TestGetThreads:
    def _setup_threads(self, ch, threads_data):
        threads_col = ch._db.collection.return_value

        # Build query chain
        query = threads_col.where.return_value
        query.order_by.return_value = query
        query.limit.return_value = query
        query.start_after.return_value = query

        docs = []
        for t in threads_data:
            doc = MagicMock()
            doc.to_dict.return_value = t
            doc.id = t.get("thread_id", "t1")
            docs.append(doc)
        query.stream.return_value = iter(docs)

        return query

    def test_returns_threads_for_user(self):
        ch = _make_chat_history()
        self._setup_threads(
            ch,
            [
                {
                    "thread_id": "t1",
                    "status": "complete",
                    "message_count": 5,
                    "advisory_type": "crops",
                    "created_at": "2026-01-01T00:00:00",
                    "updated_at": "2026-01-01T01:00:00",
                    "preview": "my wheat has yellow leaves",
                },
            ],
        )

        threads, next_cursor = ch.get_threads("user1")

        assert len(threads) == 1
        assert threads[0]["thread_id"] == "t1"
        assert threads[0]["preview"] == "my wheat has yellow leaves"
        assert next_cursor == "2026-01-01T01:00:00"

    def test_returns_empty_when_no_threads(self):
        ch = _make_chat_history()
        self._setup_threads(ch, [])

        threads, cursor = ch.get_threads("user1")
        assert threads == []
        assert cursor is None

    def test_pagination_cursor_passed_to_query(self):
        ch = _make_chat_history()
        query = self._setup_threads(ch, [])

        ch.get_threads("user1", cursor="2026-01-01T01:00:00")

        query.start_after.assert_called_once_with(
            {"updated_at": "2026-01-01T01:00:00"}
        )


# ===================================================================
# delete_thread
# ===================================================================


class TestDeleteThread:
    def test_deletes_messages_then_thread(self):
        ch = _make_chat_history()
        threads_col = ch._db.collection.return_value
        thread_ref = threads_col.document.return_value

        thread_ref.get.return_value = _make_doc_snapshot(
            {"user_id": "user1"}, exists=True
        )

        # Messages subcollection — return one batch then empty
        msg_col = thread_ref.collection.return_value
        msg_doc = MagicMock()
        msg_doc.reference = MagicMock()

        limit_query = msg_col.limit.return_value
        limit_query.stream.side_effect = [
            iter([msg_doc]),  # first batch: 1 message
            iter([]),  # second batch: empty → stop
        ]

        batch = ch._db.batch.return_value

        result = ch.delete_thread("user1", "t1")

        assert result is True
        batch.delete.assert_called_once_with(msg_doc.reference)
        batch.commit.assert_called_once()
        thread_ref.delete.assert_called_once()

    def test_returns_false_for_missing_thread(self):
        ch = _make_chat_history()
        threads_col = ch._db.collection.return_value
        thread_ref = threads_col.document.return_value
        thread_ref.get.return_value = _make_doc_snapshot({}, exists=False)

        assert ch.delete_thread("user1", "t1") is False

    def test_returns_false_for_wrong_user(self):
        ch = _make_chat_history()
        threads_col = ch._db.collection.return_value
        thread_ref = threads_col.document.return_value
        thread_ref.get.return_value = _make_doc_snapshot(
            {"user_id": "other"}, exists=True
        )

        assert ch.delete_thread("user1", "t1") is False

    def test_returns_false_on_error(self):
        ch = _make_chat_history()
        ch._db.collection.side_effect = Exception("boom")

        assert ch.delete_thread("u", "t") is False


# ===================================================================
# health_check
# ===================================================================


class TestHealthCheck:
    def test_success(self):
        ch = _make_chat_history()
        health_col = ch._db.collection.return_value
        test_ref = health_col.document.return_value
        test_ref.get.return_value = _make_doc_snapshot({"ok": True}, exists=True)

        assert ch.health_check() is True
        test_ref.set.assert_called_once()
        test_ref.delete.assert_called_once()

    def test_fails_when_read_returns_missing(self):
        ch = _make_chat_history()
        health_col = ch._db.collection.return_value
        test_ref = health_col.document.return_value
        test_ref.get.return_value = _make_doc_snapshot({}, exists=False)

        assert ch.health_check() is False

    def test_fails_when_no_client(self):
        ch = _make_chat_history()
        ch._db = None

        assert ch.health_check() is False

    def test_fails_on_exception(self):
        ch = _make_chat_history()
        ch._db.collection.side_effect = Exception("kaboom")

        assert ch.health_check() is False


# ===================================================================
# Error resilience — logging failures must not crash
# ===================================================================


class TestErrorResilience:
    def test_save_message_exception_returns_false(self):
        ch = _make_chat_history()
        ch._db.collection.side_effect = RuntimeError("network error")

        result = ch.save_message("u", "t", "user", "hello")
        assert result is False

    def test_get_threads_exception_returns_empty(self):
        ch = _make_chat_history()
        ch._db.collection.side_effect = RuntimeError("timeout")

        threads, cursor = ch.get_threads("u")
        assert threads == []
        assert cursor is None

    def test_get_messages_exception_returns_empty(self):
        ch = _make_chat_history()
        ch._db.collection.side_effect = RuntimeError("timeout")

        msgs, cursor = ch.get_messages("u", "t")
        assert msgs == []
        assert cursor is None

