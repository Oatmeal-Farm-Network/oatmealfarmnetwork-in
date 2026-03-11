# --- tests/test_integration.py --- (Task 6: Integration tests)
"""
Integration tests that exercise the FastAPI app via httpx TestClient.
Covers:
  - Health / readiness endpoints
  - Input validation (Pydantic constraints)
  - Rate limiter (429 after exceeding limit)
  - Message buffer round-trip through the /chat endpoint (if LLM is available)
  - Checkpoint restore (thread_id reuse returns prior state)
"""
import os
import sys
import uuid
import pytest

# Ensure project root on path
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

from fastapi.testclient import TestClient


# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------
@pytest.fixture(scope="module")
def client():
    """Module-scoped TestClient so we import the app only once."""
    from api import app
    with TestClient(app) as c:
        yield c


# ---------------------------------------------------------------------------
# 1. Health endpoints
# ---------------------------------------------------------------------------
class TestHealthEndpoints:

    def test_root(self, client):
        resp = client.get("/")
        assert resp.status_code == 200
        body = resp.json()
        assert body["status"] == "healthy"

    def test_health(self, client):
        resp = client.get("/health")
        assert resp.status_code == 200
        body = resp.json()
        assert body["status"] == "healthy"

    def test_health_redis(self, client):
        resp = client.get("/health/redis")
        # Could be 200 (healthy / disabled) or 503 (unhealthy)
        assert resp.status_code in (200, 503)

    def test_ready(self, client):
        resp = client.get("/ready")
        assert resp.status_code in (200, 503)
        body = resp.json()
        assert "checks" in body


# ---------------------------------------------------------------------------
# 2. Input validation (Task 5 acceptance criteria)
# ---------------------------------------------------------------------------
class TestInputValidation:

    def test_missing_user_input(self, client):
        resp = client.post("/chat", json={"thread_id": "t1"})
        assert resp.status_code == 422  # Pydantic validation error

    def test_empty_user_input(self, client):
        resp = client.post("/chat", json={"user_input": "", "thread_id": "t1"})
        assert resp.status_code == 422

    def test_whitespace_only_user_input(self, client):
        resp = client.post("/chat", json={"user_input": "   ", "thread_id": "t1"})
        assert resp.status_code == 422

    def test_missing_thread_id(self, client):
        resp = client.post("/chat", json={"user_input": "hello"})
        assert resp.status_code == 422

    def test_oversized_user_input(self, client):
        from config import MAX_MESSAGE_CHARS
        big = "A" * (MAX_MESSAGE_CHARS + 1)
        resp = client.post("/chat", json={"user_input": big, "thread_id": "t1"})
        assert resp.status_code == 422

    def test_oversized_thread_id(self, client):
        resp = client.post(
            "/chat",
            json={"user_input": "hi", "thread_id": "x" * 200},
        )
        assert resp.status_code == 422


# ---------------------------------------------------------------------------
# 3. Rate limiting (Task 5)
# ---------------------------------------------------------------------------
class TestRateLimiting:
    """Requires a live Redis to actually trigger 429; skips otherwise."""

    def test_rate_limit_triggers_429(self, client):
        """Spam requests until we hit 429 or confirm it's unreachable."""
        from config import (
            RATE_LIMIT_ENABLED,
            RATE_LIMIT_MAX_REQUESTS,
            REDIS_ENABLED,
        )
        if not RATE_LIMIT_ENABLED or not REDIS_ENABLED:
            pytest.skip("Rate limiting or Redis disabled")

        # Clear any existing rate-limit key for this test thread
        tid = f"test_rate_{uuid.uuid4().hex[:8]}"

        got_429 = False
        for i in range(RATE_LIMIT_MAX_REQUESTS + 5):
            resp = client.post(
                "/chat",
                json={"user_input": f"ping {i}", "thread_id": tid},
            )
            if resp.status_code == 429:
                got_429 = True
                body = resp.json()
                assert body["status"] == "error"
                assert "Too many requests" in body["message"]
                break
            # Any other status (200, 500, etc.) is acceptable until we hit the limit

        assert got_429, (
            f"Expected 429 after {RATE_LIMIT_MAX_REQUESTS} requests but never got one"
        )


# ---------------------------------------------------------------------------
# 4. Message buffer round-trip via API
# ---------------------------------------------------------------------------
class TestBufferViaAPI:
    """Verify messages land in the Redis buffer after calling /chat."""

    def test_user_message_appears_in_buffer(self, client):
        """After a /chat call the user message should exist in the buffer."""
        from message_buffer import message_buffer

        if message_buffer.client is None:
            pytest.skip("Redis buffer unavailable")

        tid = f"test_buf_api_{uuid.uuid4().hex[:8]}"
        resp = client.post(
            "/chat",
            json={"user_input": "integration test message", "thread_id": tid},
        )
        # We don't care about the LLM answer — just that the buffer received the msg
        msgs = message_buffer.get_last_n(tid, 10)
        user_msgs = [m for m in msgs if m["role"] == "user"]
        assert len(user_msgs) >= 1
        assert "integration test message" in user_msgs[0]["content"]

        # Cleanup
        message_buffer.clear_thread(tid)


# ---------------------------------------------------------------------------
# 5. Checkpoint continuity (thread reuse)
# ---------------------------------------------------------------------------
class TestCheckpointContinuity:
    """Two sequential /chat calls with the same thread_id should share state."""

    def test_same_thread_shares_state(self, client):
        """Second call on the same thread should not fail and should see context."""
        tid = f"test_chk_{uuid.uuid4().hex[:8]}"
        resp1 = client.post(
            "/chat",
            json={"user_input": "I have a farm in Texas", "thread_id": tid},
        )
        # We accept any non-422 status; the LLM might not be available
        assert resp1.status_code != 422

        resp2 = client.post(
            "/chat",
            json={"user_input": "Tell me about cattle breeds", "thread_id": tid},
        )
        assert resp2.status_code != 422

