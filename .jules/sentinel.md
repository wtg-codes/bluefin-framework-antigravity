## 2024-04-22 - Unverified Binary Download
**Vulnerability:** Unverified binary download in `files/workspace/Containerfile` (kubectl installation).
**Learning:** The previous installation downloaded the `kubectl` binary directly and installed it without verifying its integrity against the official checksum, exposing the build to MITM or supply chain attacks.
**Prevention:** Always download the official checksum file alongside the binary and verify it using `sha256sum -c` before installation.

## 2026-04-27 - Insecure Installation Script Execution & Dynamic Checksum Weakness
**Vulnerability:** Execution of an unverified shell script via 'curl | sh' pattern to install Helm, and attempting to verify with dynamically downloaded checksums.
**Learning:**
1. Executing downloaded shell scripts (`curl | sh`) obscures operations and risks arbitrary code execution, which is an insecure pattern for container builds.
2. Dynamically fetching the latest release via GitHub API unauthenticated leads to CI rate-limiting failures.
3. Dynamically downloading and trusting a `.sha256sum` file from the same origin as the binary degrades security, as a compromised server can simply replace both the binary and the checksum.
**Prevention:** Avoid executing installation shell scripts. Hardcode dependencies and their checksums. Securely download the compiled binary release, verify its integrity using the hardcoded checksum and 'sha256sum -c', and install the binary directly.
