## 2024-04-22 - Unverified Binary Download
**Vulnerability:** Unverified binary download in `files/workspace/Containerfile` (kubectl installation).
**Learning:** The previous installation downloaded the `kubectl` binary directly and installed it without verifying its integrity against the official checksum, exposing the build to MITM or supply chain attacks.
**Prevention:** Always download the official checksum file alongside the binary and verify it using `sha256sum -c` before installation.

## 2024-05-01 - Dynamic Download Checksums and Executables
**Vulnerability:** Insecure dynamic executable downloads and `curl | sh` installations without validation (k9s, helm).
**Learning:** Fetching versions via GitHub API at build time without explicit pinning, and evaluating bash scripts downloaded via `curl | sh`, compromises build integrity. Downloading a checksum file dynamically defeats the purpose of validation against a MITM attack.
**Prevention:** Always hardcode known good versions, download binaries securely, and verify against a **hardcoded** SHA256 checksum string natively within the `Containerfile`.
