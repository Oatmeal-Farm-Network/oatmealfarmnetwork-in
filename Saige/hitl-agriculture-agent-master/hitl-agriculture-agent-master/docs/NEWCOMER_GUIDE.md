# Newcomer Guide: HITL Agriculture Agent

This document is a quick orientation for engineers joining this repository.

## 1) What this project is

The app is an **AI agriculture assistant** that combines:
- A **Next.js frontend** chat experience.
- A **FastAPI backend** API.
- A **LangGraph workflow** to drive multi-step assessment + advisory logic.
- **Gemini (via LangChain)** for classification, follow-up questioning, and final responses.
- Optional integrations for **weather APIs**, **Firestore chat history**, and **RAG over livestock knowledge**.

At a high level:

```text
Browser (Next.js) -> /api/chat (FastAPI) -> LangGraph nodes -> LLM/tools -> response
```

## 2) Top-level structure

### Backend core (repo root)

- `api.py`
  - Entry point for HTTP requests (`/chat`, health/readiness routes).
  - Handles CORS, request logging, global exception handling, chat persistence hooks, and interaction with the LangGraph state machine.
- `graph.py`
  - Builds and compiles the LangGraph `StateGraph`.
  - Defines nodes and conditional routes among assessment, routing, and advisory nodes.
- `nodes.py`
  - Most of the business logic:
    - User assessment flow (questioning/interrupts).
    - Query-type routing (`weather`, `livestock`, `crops`, `mixed`).
    - Advisory generation and optional tool usage.
- `models.py`
  - Shared schema definitions:
    - `FarmState` (graph state contract).
    - Pydantic models for structured LLM outputs.
- `config.py`
  - Environment/config loading and feature flags.
  - Determines whether optional integrations are available.
- `llm.py`
  - Initializes Gemini client (Vertex AI mode or Developer API mode).
- `weather.py`
  - Weather service abstraction + tool callable by the LLM.
- `rag.py`
  - Firestore vector-search retrieval for livestock context.
- `chat_history.py`
  - Firestore-backed storage of conversation threads/messages.

### Frontend (`frontend/`)

- `frontend/components/advisor.tsx`
  - Main chat UX and quiz-like follow-up UI.
  - Manages thread id, message timeline, loading states, and `/api/chat` calls.
- `frontend/app/page.tsx`
  - Renders the advisor component.
- `frontend/next.config.ts`
  - Runtime config/proxy setup.

### Ops/Deployment

- `Dockerfile.backend` and `frontend/Dockerfile`
  - Containerization for backend/frontend.
- `.github/workflows/deploy.yml`
  - CI/CD pipeline deploying both services to Cloud Run.

## 3) Request lifecycle (important mental model)

1. User submits text in `advisor.tsx`.
2. Frontend POSTs `{ user_input, thread_id }` to backend `/chat`.
3. `api.py` loads graph state by thread id.
4. Graph either:
   - Continues an interrupted assessment (if waiting for user answer), or
   - Starts/continues assessment-routing-advisory path.
5. `nodes.py` decides whether to ask more questions, route to weather/livestock/crops/mixed, and generate diagnosis/recommendations.
6. API returns either:
   - `requires_input` with UI question/options, or
   - `complete` with diagnosis/recommendations.
7. Frontend updates chat accordingly.

## 4) Concepts you should understand first

- **LangGraph interrupt/resume pattern**
  - Assessment can pause for user input and resume later using the same `thread_id`.
- **State-first design (`FarmState`)**
  - Nodes communicate entirely by reading/writing typed state fields.
- **Hybrid routing logic**
  - Routing first tries deterministic keyword logic, then falls back to LLM classification for ambiguous inputs.
- **Optional capability flags**
  - Weather and RAG features are soft-enabled based on installed dependencies and env vars.
- **Persistence boundaries**
  - LangGraph memory checkpoint is for in-process conversation state.
  - Firestore chat history is for durable user message/thread history.

## 5) Important things to watch out for

- **Environment variables are essential**
  - Missing Gemini credentials will break LLM initialization.
  - Missing weather/RAG credentials disable those features.
- **State shape consistency matters**
  - New nodes or fields should remain compatible with `FarmState` and existing API response expectations.
- **Thread IDs are critical**
  - Conversation continuity depends on stable `thread_id` from the frontend.
- **Debug logging is currently noisy in places**
  - Some files include extra ad-hoc debug telemetry/log lines; review before production hardening.

## 6) Local development orientation

Backend:
1. Create Python env, install `requirements.txt`.
2. Provide `.env` values (Gemini API key or Vertex settings).
3. Run FastAPI app (typically via Uvicorn).

Frontend:
1. `cd frontend && npm install`.
2. Run Next.js dev server.
3. Ensure frontend can reach backend `/chat` (through configured proxy/env URL).

## 7) “Where do I change X?” quick map

- Change question-asking or assessment completion logic: `nodes.py` (`assessment_node`).
- Change route decisions among weather/crops/livestock/mixed: `nodes.py` (`routing_node`, route helpers).
- Change final advice style/content: advisory node prompts in `nodes.py`.
- Change API contract or response payloads: `api.py`.
- Change chat UX behavior (bubbles, loading, quiz forms): `frontend/components/advisor.tsx`.
- Change deploy behavior: `.github/workflows/deploy.yml`, Dockerfiles.

## 8) Suggested learning path for newcomers

1. **Read `models.py` first** to understand state and structured outputs.
2. **Read `graph.py`** to understand node topology and transitions.
3. **Read `nodes.py` in this order**:
   - `assessment_node`
   - routing logic
   - advisory engine (`run_advisory_agent` + specialized nodes)
4. **Read `api.py`** to see how HTTP maps to graph events and responses.
5. **Run frontend + backend locally** and follow a full chat session.
6. **Explore optional systems** (`weather.py`, `rag.py`, `chat_history.py`) once baseline flow is clear.

## 9) Good “next tasks” for onboarding practice

- Add a new routing category (e.g., soil-nutrients) end-to-end.
- Improve one structured output model and update downstream handling.
- Add tests for one full interrupt/resume conversation path.
- Remove/harden ad-hoc debug logging and standardize structured logs.
- Add API docs examples for `requires_input` vs `complete` response states.

---
If you only remember one thing: this codebase is a **stateful conversation workflow**; most changes are safest when made by tracing how `FarmState` evolves across graph nodes.
