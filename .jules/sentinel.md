## 2024-04-22 - Unverified Binary Download
**Vulnerability:** Unverified binary download in `files/workspace/Containerfile` (kubectl installation).
**Learning:** The previous installation downloaded the `kubectl` binary directly and installed it without verifying its integrity against the official checksum, exposing the build to MITM or supply chain attacks.
**Prevention:** Always download the official checksum file alongside the binary and verify it using `sha256sum -c` before installation.
## 2024-05-24 - [Insecure Helm Download in Containerfile]
**Vulnerability:** Execution of a remote script using `curl | sh` without version pinning or checksum validation.
**Learning:** This pattern is vulnerable to supply chain attacks. The lack of checksum validation allows a compromised remote server to inject malicious code during the build process.
**Prevention:** Pin dependencies to specific versions and verify downloaded files against hardcoded, known-good checksums before executing or extracting them. Use `sha256sum -c` to enforce this.
