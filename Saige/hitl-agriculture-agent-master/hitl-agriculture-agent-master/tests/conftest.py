# --- tests/conftest.py --- (Shared pytest fixtures for Task 6 tests)
"""
Provides a live Redis client fixture that:
  - Skips tests if Redis is unreachable.
  - Uses a dedicated test DB / key prefix so tests never pollute production data.
  - Cleans up all test keys after each test.
"""
import os
import sys
import pytest

# Ensure project root is on sys.path for imports
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

import redis as _redis

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
_TEST_REDIS_URL = os.getenv("TEST_REDIS_URL", "redis://localhost:6379/1")
_TEST_KEY_PREFIX = "test:"


# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------
@pytest.fixture(scope="session")
def redis_url():
    """Canonical Redis URL used by the test suite."""
    return _TEST_REDIS_URL


@pytest.fixture(scope="session")
def redis_client_session(redis_url):
    """Session-scoped Redis client; skips if unreachable."""
    try:
        client = _redis.Redis.from_url(redis_url, decode_responses=True, socket_connect_timeout=3)
        client.ping()
    except Exception as exc:
        pytest.skip(f"Redis unavailable at {redis_url}: {exc}")
    yield client
    client.close()


@pytest.fixture()
def redis_client(redis_client_session):
    """
    Per-test Redis client.
    After each test, deletes all keys matching the test prefix.
    """
    yield redis_client_session
    # Cleanup: remove any keys created during the test
    for key in redis_client_session.scan_iter(f"{_TEST_KEY_PREFIX}*"):
        redis_client_session.delete(key)
    # Also clean up thread:test_* keys used by MessageBuffer
    for key in redis_client_session.scan_iter("thread:test_*"):
        redis_client_session.delete(key)


@pytest.fixture()
def make_buffer(redis_client):
    """
    Factory fixture: creates a fresh MessageBuffer wired to the test Redis client.
    """
    from message_buffer import MessageBuffer

    def _factory(buffer_size=20, ttl_seconds=86400):
        buf = MessageBuffer.__new__(MessageBuffer)
        buf.client = redis_client
        buf._shared_client = True
        buf.buffer_size = buffer_size
        buf.ttl_seconds = ttl_seconds
        return buf

    return _factory

