# --------------------------------------------
# Local CI/CD pipeline for Minikube + Helm
# --------------------------------------------

# 1️⃣ Ensure Minikube is running
Write-Host "Starting Minikube..."
minikube start

# 2️⃣ Point Docker CLI to Minikube's Docker daemon
Write-Host "Setting Docker to use Minikube daemon..."
& minikube -p minikube docker-env --shell powershell | Invoke-Expression

# 3️⃣ Build Docker image locally
Write-Host "Building Docker image sample-app:latest..."
docker build -t sample-app:latest ./app

# 4️⃣ Deploy/upgrade Helm chart
Write-Host "Deploying Helm chart..."
helm upgrade --install sample-app ./charts/sample-app

# 5️⃣ Wait for pods to be ready
Write-Host "Waiting for pods to be ready..."
kubectl rollout status deployment/sample-app

# 6️⃣ Show pod status
kubectl get pods

# 7️⃣ Optional: Port-forward service to localhost
Write-Host "Port-forwarding service sample-app to localhost:8080..."
kubectl port-forward svc/sample-app 8080:8080