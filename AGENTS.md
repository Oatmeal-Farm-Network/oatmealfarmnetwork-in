# AGENTS.md

## Cursor Cloud specific instructions

### What this repo is
This is the **frontend-only** React 19 + Vite 7 SPA for Oatmeal Farm Network. There is
no backend in this repo — the FastAPI backend and Saige AI service live in the separate
`oatmealfarmnetworkbackend` repo and are **not** available in this environment.

### Services
There is a single service: the Vite dev server.

| Task | Command | Notes |
|------|---------|-------|
| Run (dev) | `npm run dev` | Serves at `http://localhost:5173` |
| Lint | `npm run lint` | See caveat below |
| Build | `npm run build` | Outputs static assets to `dist/` |
| Preview build | `npm run preview` | Serves the built `dist/` |

Standard commands are documented in `README.md` and `package.json`.

### Non-obvious caveats
- **No backend / no database here.** The dev server proxies `/auth`, `/api`, `/saige`,
  `/cm` to `http://127.0.0.1:8000` (see `vite.config.js`), but nothing runs there in this
  environment. Data-driven pages (login, marketplace, directory search, form submission)
  will show API/network errors — this is expected. Pure client-side features work fully:
  routing, navigation menus, and the i18n language switcher (globe icon; locales are static
  files under `public/locales/`).
- **No automated tests.** There is no test script or test framework in this repo. Verify
  changes with `npm run lint`, `npm run build`, and manual checks against the dev server.
- **`npm run lint` reports many pre-existing errors** (900+, mostly `react-refresh/only-export-components`
  and `react-hooks/set-state-in-effect`) that exist on `main` and are unrelated to environment
  setup. Do not treat a non-zero lint exit as a broken environment; compare against `main`
  when judging whether your change introduced new lint problems.
- **Node:** developed/tested with Node 22 (README says 18+, Dockerfile uses 20). All three work.
- The dev server intentionally does **not** watch `public/images/**` and `public/locales/**`
  (33k+ files) for HMR performance — edits to those static folders won't hot-reload.
- Stray `*.py` files exist under `src/` (e.g. `auth.py`, `main.py`); they are not part of the
  Vite build and can be ignored.
