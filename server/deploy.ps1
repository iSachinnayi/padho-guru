# पढ़ो गुरु — Server Deployment Script (Run this to deploy to Cloud Run)
# Prerequisites:
#   1. Firebase CLI logged in (firebase login)
#   2. gcloud CLI installed and authenticated
#   3. OpenAI API key stored in Secret Manager:
#      gcloud secrets create openai-api-key --data-file=<(echo "sk-your-key-here")
#
# Run with: PowerShell -ExecutionPolicy Bypass .\deploy.ps1

Write-Host "🚀 पढ़ो गुरु — Server Deployment" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

# Check if gcloud is installed
if (-not (Get-Command gcloud -ErrorAction SilentlyContinue)) {
    Write-Host "❌ gcloud CLI not found. Install from: https://cloud.google.com/sdk/docs/install" -ForegroundColor Red
    exit 1
}

# Check if docker is running
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Docker not found. Install Docker Desktop first." -ForegroundColor Red
    exit 1
}

Write-Host "`n📦 Step 1: Building Docker image..." -ForegroundColor Yellow
& docker build -t gcr.io/padho-guru-d28b7/padho-guru-server -f Dockerfile .

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "`n📤 Step 2: Pushing to Google Container Registry..." -ForegroundColor Yellow
& docker push gcr.io/padho-guru-d28b7/padho-guru-server

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Push failed! Make sure you're authenticated with gcloud." -ForegroundColor Red
    exit 1
}

Write-Host "`n☁️  Step 3: Deploying to Cloud Run..." -ForegroundColor Yellow
& gcloud run deploy padho-guru-server `
    --image=gcr.io/padho-guru-d28b7/padho-guru-server `
    --region=asia-south1 `
    --platform=managed `
    --allow-unauthenticated `
    --memory=512Mi `
    --cpu=1 `
    --min-instances=0 `
    --max-instances=10 `
    --concurrency=80 `
    --timeout=300

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ Deployment complete!" -ForegroundColor Green
    
    # Get the deployed URL
    $url = & gcloud run services describe padho-guru-server --region=asia-south1 --format="value(status.url)"
    Write-Host "🌐 Server URL: $url" -ForegroundColor Cyan
    Write-Host "`nUpdate your Flutter app's ai_service.dart with this URL." -ForegroundColor Yellow
} else {
    Write-Host "❌ Deploy failed!" -ForegroundColor Red
    exit 1
}
