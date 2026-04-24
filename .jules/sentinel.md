## 2024-04-22 - Unverified Binary Download
**Vulnerability:** Unverified binary download in `files/workspace/Containerfile` (kubectl installation).
**Learning:** The previous installation downloaded the `kubectl` binary directly and installed it without verifying its integrity against the official checksum, exposing the build to MITM or supply chain attacks.
**Prevention:** Always download the official checksum file alongside the binary and verify it using `sha256sum -c` before installation.
