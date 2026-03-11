# Cloud Run Deployment Setup Guide

This guide will help you set up the CI/CD pipeline for deploying the frontend and backend to Google Cloud Run.

## Prerequisites

1. Google Cloud Project with billing enabled
2. GitHub repository with Actions enabled
3. Google Cloud SDK installed locally (for initial setup)
4. Redis for production (recommended: GCP Memorystore for Redis)

## Step 1: Enable Required Google Cloud APIs

Run these commands to enable the necessary APIs:

```bash
gcloud config set project YOUR_PROJECT_ID
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable artifactregistry.googleapis.com
gcloud services enable containerregistry.googleapis.com
```

## Step 2: Create Artifact Registry Repository

Create a Docker repository in Artifact Registry:

```bash
gcloud artifacts repositories create docker-repo \
  --repository-format=docker \
  --location=us-central1 \
  --description="Docker repository for HITL-AG-AGENT"
```

## Step 3: Create Service Account for GitHub Actions

1. Create a service account:

```bash
gcloud iam service-accounts create github-actions-sa \
  --display-name="GitHub Actions Service Account"
```

2. Grant necessary permissions:

```bash
PROJECT_ID=$(gcloud config get-value project)
SA_EMAIL="github-actions-sa@${PROJECT_ID}.iam.gserviceaccount.com"

# Grant Cloud Run Admin role
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/run.admin"

# Grant Service Account User role
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/iam.serviceAccountUser"

# Grant Artifact Registry Writer role
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/artifactregistry.writer"

# Grant Storage Admin (for pulling images)
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/storage.admin"
```

3. Create and download the service account key:

```bash
gcloud iam service-accounts keys create github-actions-key.json \
  --iam-account=$SA_EMAIL
```

## Step 4: Configure GitHub Secrets

Go to your GitHub repository → Settings → Secrets and variables → Actions, and add:

1. **GCP_PROJECT_ID**: Your Google Cloud Project ID (e.g., `animated-flare-421518`)
2. **GCP_SA_KEY**: The entire contents of the `github-actions-key.json` file created in Step 3
3. **REDIS_URL**: Production Redis connection string (recommended Memorystore private IP URL, e.g., `redis://10.x.x.x:6379/0`)
4. **CLOUD_RUN_VPC_CONNECTOR** *(optional but recommended for Memorystore)*: Serverless VPC connector name
5. **CLOUD_RUN_VPC_EGRESS** *(optional)*: `private-ranges-only` or `all-traffic`

## Step 5: Update Workflow Configuration (Optional)

If you need to customize the deployment, edit `.github/workflows/deploy.yml`:

- **REGION**: Change `us-central1` to your preferred region
- **GAR_LOCATION**: Change if using a different Artifact Registry location
- **Memory/CPU**: Adjust resource limits for Cloud Run services
- **Environment Variables**: Backend picks up `REDIS_URL` from secrets when provided
- **Network**: Set optional `--vpc-connector`/`--vpc-egress` for private Redis access

## Step 6: Provision Redis in Production (Memorystore Recommended)

For Cloud Run + private Redis connectivity, use Memorystore with a Serverless VPC connector.

### 6.1 Create Memorystore Redis instance

```bash
gcloud redis instances create farm-advisory-redis \
  --size=1 \
  --region=us-central1 \
  --redis-version=redis_7_0 \
  --network=default
```

Get host IP:

```bash
gcloud redis instances describe farm-advisory-redis \
  --region=us-central1 \
  --format='value(host)'
```

Set GitHub secret `REDIS_URL`:

```text
redis://<memorystore-host>:6379/0
```

### 6.2 Create Serverless VPC connector

```bash
gcloud compute networks vpc-access connectors create cloudrun-redis-connector \
  --region=us-central1 \
  --network=default \
  --range=10.8.0.0/28
```

Set GitHub secret `CLOUD_RUN_VPC_CONNECTOR`:

```text
cloudrun-redis-connector
```

Optional egress behavior (`CLOUD_RUN_VPC_EGRESS`):
- `private-ranges-only` (recommended default)
- `all-traffic`
## Step 7: Deploy

The workflow will automatically trigger on:
- Push to `main` or `master` branch
- Manual trigger via GitHub Actions UI (workflow_dispatch)

## Manual Deployment (Alternative)

If you prefer to deploy manually:

### Backend:
```bash
# Build
docker build -f Dockerfile.backend -t gcr.io/YOUR_PROJECT_ID/HITL-AG-AGENT-BACKEND .

# Push
docker push gcr.io/YOUR_PROJECT_ID/HITL-AG-AGENT-BACKEND

# Deploy
gcloud run deploy HITL-AG-AGENT-BACKEND \
  --image gcr.io/YOUR_PROJECT_ID/HITL-AG-AGENT-BACKEND \
  --region us-central1 \
  --platform managed \
  --allow-unauthenticated \
  --port 8000
```

### Frontend:
```bash
# Build
docker build -f frontend/Dockerfile -t gcr.io/YOUR_PROJECT_ID/HITL-AG-AGENT-FRONTEND ./frontend

# Push
docker push gcr.io/YOUR_PROJECT_ID/HITL-AG-AGENT-FRONTEND

# Deploy
gcloud run deploy HITL-AG-AGENT-FRONTEND \
  --image gcr.io/YOUR_PROJECT_ID/HITL-AG-AGENT-FRONTEND \
  --region us-central1 \
  --platform managed \
  --allow-unauthenticated \
  --port 3000
```

## Environment Variables for Backend

After deployment, you may need to set environment variables for the backend service:

```bash
gcloud run services update HITL-AG-AGENT-BACKEND \
  --region us-central1 \
  --set-env-vars "GOOGLE_API_KEY=your-key,GOOGLE_CLOUD_PROJECT=your-project-id,REDIS_ENABLED=true,REDIS_URL=redis://10.x.x.x:6379/0"
```

Or use Secret Manager for sensitive values:

```bash
# Create secret
echo -n "your-api-key" | gcloud secrets create google-api-key --data-file=-

# Grant access
gcloud secrets add-iam-policy-binding google-api-key \
  --member="serviceAccount:YOUR_SERVICE_ACCOUNT@PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/secretmanager.secretAccessor"

# Update service to use secret
gcloud run services update HITL-AG-AGENT-BACKEND \
  --region us-central1 \
  --update-secrets="GOOGLE_API_KEY=google-api-key:latest"
```

## Troubleshooting

1. **Authentication errors**: Ensure the service account has the correct permissions
2. **Build failures**: Check that all dependencies are correctly specified
3. **Deployment errors**: Verify the Artifact Registry repository exists and is accessible
4. **Runtime errors**: Check Cloud Run logs: `gcloud run services logs read SERVICE_NAME --region REGION`

