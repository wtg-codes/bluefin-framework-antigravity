#!/usr/bin/env bash
# ==============================================================================
# Jules Agent Setup Script for bluefin-framework-antigravity
# This script configures the Jules cloud VM to mimic the wtgOS development
# environment, enabling the agent to run tests, build docs, and interact with APIs.
# ==============================================================================
set -euo pipefail

# Ensure we are executing from the repository root so relative folders like "website" resolve
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "🚀 Initializing Graduate-Level Jules Environment for wtgOS..."

# 1. CNCF & OS Tooling (BATS & Just)
# Jules needs BATS to run tests/os_validation.bats and Just to simulate ujust
echo "🛠️ Installing BATS and Just..."
sudo apt-get update -y
sudo apt-get install -y bats curl jq

if ! command -v just &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | sudo bash -s -- --to /usr/local/bin
fi

# 2. Docusaurus Website Dependencies
# Your pages.yml and package.json require Node >= 20.0 (using Node 22 in CI)
echo "📦 Installing Docusaurus dependencies for /website..."
if [ -d "website" ]; then
    cd website
    npm ci # Clean install for accurate dependency tree
    cd ..
fi

# 3. AI Agent Dependencies (Gemini CLI & Google ADK)
# Mirrors the steps in files/workspace/Containerfile
echo "🤖 Setting up Google ADK and Gemini CLI..."

# 4. GCP & API Configuration (Optional / Conditional)
# If you add GCP_PROJECT_ID to the Jules Environment Variables UI, this activates.
if [ -n "${GCP_PROJECT_ID:-}" ]; then
    echo "☁️ Configuring Google Cloud Project: $GCP_PROJECT_ID"
    # Authenticate if credentials JSON is provided via Jules Env Vars
    if [ -n "${GOOGLE_APPLICATION_CREDENTIALS_JSON:-}" ]; then
        echo "$GOOGLE_APPLICATION_CREDENTIALS_JSON" > /tmp/gcp_key.json
        gcloud auth activate-service-account --key-file=/tmp/gcp_key.json
        gcloud config set project "$GCP_PROJECT_ID"
        rm -f /tmp/gcp_key.json
    else
        echo "⚠️ GCP_PROJECT_ID set, but no GOOGLE_APPLICATION_CREDENTIALS_JSON found. Skipping auth."
    fi
fi

# 5. Local Validation Pre-flight Check
# Run a quick sanity check to ensure the agent environment is healthy
echo "🧪 Running environment sanity checks..."
node -v
bats --version
just --version

echo "✅ Jules Environment Setup Complete! Snapshot ready."
