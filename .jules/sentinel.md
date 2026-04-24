
## 2024-05-24 - [Secure Binary Verification in Containerfile]
**Vulnerability:** The `kubectl` binary was being downloaded and installed directly in the `Containerfile` via `curl | install` without any verification of the downloaded binary's integrity or authenticity.
**Learning:** This exposes the build process to potential supply chain attacks or MITM attacks where a compromised binary could be injected.
**Prevention:** Always securely download the release, fetch its associated checksum file, and explicitly verify the binary using `sha256sum -c` before installing it. For example, `echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c -` handles verification cleanly. Enforce this via a BATS test that counts `sha256sum -c` occurrences in the `Containerfile`.
