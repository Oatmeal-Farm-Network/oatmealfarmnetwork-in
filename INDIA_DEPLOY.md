# India deployment scaffold (CI/CD + Cloud Run + WIF)

USA production stays in `oatmealfarmnetwork`. This repo deploys India frontend.

## Auth model

GitHub Actions uses **Workload Identity Federation** (no JSON key secret).

## One-time GCP setup

```bash
gcloud auth login
chmod +x scripts/setup-india-wif.sh
./scripts/setup-india-wif.sh
```

Also bootstrap Cloud Run/Artifact Registry if needed:

```bash
chmod +x scripts/setup-india-cloud.sh
./scripts/setup-india-cloud.sh
```

## GitHub secrets (`oatmealfarmnetwork-in`)

| Secret | Value |
|--------|--------|
| `WORKLOAD_IDENTITY_PROVIDER` | printed by setup script (`projects/802455386518/locations/global/workloadIdentityPools/.../providers/...`) |
| `GOOGLE_SERVICE_ACCOUNT` | `github-deploy-india@animated-flare-421518.iam.gserviceaccount.com` |
| `GOOGLE_CLOUD_PROJECT` | `animated-flare-421518` |
| `GOOGLE_CLOUD_LOCATION` | `asia-south1` |

Do **not** add `GOOGLE_APPLICATION_CREDENTIALS` JSON for Actions.
