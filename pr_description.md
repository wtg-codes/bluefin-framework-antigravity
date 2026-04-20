🎯 **What:** The vulnerability fixed was the explicit disabling of Chromium and Electron security sandboxing features via `--no-sandbox` flags in the `Containerfile` startup wrappers.

⚠️ **Risk:** The potential impact if left unfixed is that Chromium/Electron browser processes running within the container would execute completely without unprivileged user namespaces and sandboxing logic, which increases the blast radius of any RCE (Remote Code Execution) or other browser exploits. Disabling sandbox mechanisms breaks the security boundaries enforced by the browser.

🛡️ **Solution:** The fix adds/updates wrapper scripts in `files/workspace/Containerfile` that omit the insecure `--no-sandbox` flag while preserving `--disable-dev-shm-usage` which is still necessary for stable container execution without shared memory limits. Unprivileged user namespaces and container runtime configurations natively handle the permissions required to utilize the built-in Chromium sandbox.
