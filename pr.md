🎯 **What:** The vulnerability fixed was the passing of the host's `podman.sock` into the workspace, which opened up a privilege escalation path. The PR before this removed the socket, but failed to preserve the intended functionality for `kind`. This PR moves `kind` execution to the immutable host.

⚠️ **Risk:** The potential impact if left unfixed was that an AI agent or any process in the workspace could mount root paths via the passed-through Podman socket. Alternatively, setting up a nested podman inside the container would violate the project's 'no nested virtualization' mandate, causing cgroup/uid map exhaustion.

🛡️ **Solution:** How the fix addresses the vulnerability:
1. Removed `kind` installation from the workspace container (`files/workspace/Containerfile`).
2. Added `kind` installation script to the host build via `recipes/recipe.yml`.
3. Configured `files/justfiles/wtgOS.just` (which executes on the host) to inject the generated `kubeconfig` back into the workspace's home directory.

The workspace is now correctly treated as a client connecting to a cluster over the network, fully eliminating the need for nested podman or host socket access.
