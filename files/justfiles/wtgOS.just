# setup-workspace: initializes the cloud-native student workspace (idempotent)
setup-workspace:
    @echo "Setting up wtgOS Workspace..."
    @mkdir -p ~/.local/share/wtg-workspace
    @distrobox assemble create --replace --file /usr/share/bluefin-framework/wtgOS/distrobox.ini

# setup-antigravity: alias for setup-workspace for legacy compatibility
setup-antigravity: setup-workspace

# start-cluster: spins up a local kind cluster using podman
start-cluster:
    @echo "Starting local Kubernetes cluster (kind) via Podman..."
    @distrobox enter wtg-workspace -- kind create cluster --provider podman

# agent-sync: pulls the latest AI agent dependencies (redundant with image but useful for live updates)
agent-sync:
    @echo "Synchronizing AI agent dependencies (Gemini CLI & ADK)..."
    @distrobox enter wtg-workspace -- npm install -g @google/gemini-cli
    @distrobox enter wtg-workspace -- pip install --break-system-packages google-adk
