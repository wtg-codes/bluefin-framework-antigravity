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
    @kind create cluster --provider podman
    @mkdir -p ~/.local/share/wtg-workspace/.kube
    @cp ~/.kube/config ~/.local/share/wtg-workspace/.kube/config || true


# test-vlm-ui: spins up an ephemeral playwright testing container
test-vlm-ui:
    @echo "Running headless UI tests via Playwright..."
    @podman run --rm --ipc=host --shm-size=2g mcr.microsoft.com/playwright:v1.58.2-noble npx playwright test
