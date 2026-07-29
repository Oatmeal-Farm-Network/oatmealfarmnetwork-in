# India deployment scaffold (CI/CD + Cloud Run)

This repo is the **India** frontend fork. USA production stays in `oatmealfarmnetwork`.

## Target cloud

| Item | Value |
|------|--------|
| GCP project | `animated-flare-421518` (same project, India services) |
| Region | `asia-south1` (Mumbai) |
| Cloud Run service | `oatmealfarmnetwork-in` |
| Artifact Registry | `asia-south1-docker.pkg.dev/.../cloud-run-source-deploy/oatmealfarmnetwork-in` |

## What was prepared

1. `cloudbuild.yaml` — builds/pushes India image in `asia-south1`
2. `.env.production` — points `VITE_*` at India Cloud Run URL pattern
3. `.github/workflows/deploy-cloud-run.yml` — GitHub Actions → build/push/deploy Cloud Run
4. `scripts/setup-india-cloud.sh` — one-time Artifact Registry + Cloud Run bootstrap

## One-time setup (someone with GCP access)

```bash
# authenticate
gcloud auth login
gcloud config set project animated-flare-421518

# bootstrap India services + registries
chmod +x scripts/setup-india-cloud.sh
./scripts/setup-india-cloud.sh
```

## GitHub secrets (India frontend repo)

| Secret | Purpose |
|--------|---------|
| `GCP_PROJECT_ID` | `animated-flare-421518` |
| `GCP_SA_KEY` | JSON key for deploy service account |

## Related India backend repo

`oatmealfarmnetworkbackend-in` — main API + Saige workflows.

## Notes for the India app team

- Language/data/content divergence can happen after this scaffold is live.
- If first Cloud Run URLs differ from the assumed `*-802455386518.asia-south1.run.app` pattern, update `.env.production` and the workflow `API_URL`.
- Do **not** push India changes to the USA `oatmealfarmnetwork` repo.
