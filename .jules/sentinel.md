## 2024-04-22 - Unverified Binary Download
**Vulnerability:** Unverified binary download in `files/workspace/Containerfile` (kubectl installation).
**Learning:** The previous installation downloaded the `kubectl` binary directly and installed it without verifying its integrity against the official checksum, exposing the build to MITM or supply chain attacks.
**Prevention:** Always download the official checksum file alongside the binary and verify it using `sha256sum -c` before installation.

## 2024-04-26 - Insecure Temporary File Generation for Credentials
**Vulnerability:** Google Cloud credentials were written to a hardcoded, world-readable file (`/tmp/gcp_key.json`) in `.jules/setup.sh`.
**Learning:** Hardcoded temporary files in `/tmp` are vulnerable to symlink attacks, and missing cleanup handlers mean failed scripts will leave sensitive credentials on disk permanently.
**Prevention:** Always use `mktemp` to generate unpredictable temporary files, explicitly set permissions (`chmod 600`), and use `trap` on `EXIT` to guarantee cleanup regardless of script success/failure.
