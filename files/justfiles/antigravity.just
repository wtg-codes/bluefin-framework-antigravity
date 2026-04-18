# setup-workspace: initializes the cloud-native student workspace
setup-workspace:
    @echo "Setting up Antigravity Cloud-Native Workspace..."
    @mkdir -p ~/.local/share/antigravity-workspace
    @distrobox assemble create --file /usr/share/bluefin-framework/antigravity/distrobox.ini

# start-cluster: spins up a local kind cluster using podman
start-cluster:
    @echo "Starting local Kubernetes cluster (kind) via Podman..."
    @distrobox enter antigravity-cloud-native -- kind create cluster --provider podman

# agent-sync: pulls the latest AI agent dependencies
agent-sync:
    @echo "Synchronizing AI agent dependencies (Gemini CLI & ADK)..."
    @distrobox enter antigravity-cloud-native -- npm install -g @google/gemini-cli
    @distrobox enter antigravity-cloud-native -- pip install google-adk
