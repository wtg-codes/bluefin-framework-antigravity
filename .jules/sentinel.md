## 2024-04-22 - Unverified Binary Download
**Vulnerability:** Unverified binary download in `files/workspace/Containerfile` (kubectl installation).
**Learning:** The previous installation downloaded the `kubectl` binary directly and installed it without verifying its integrity against the official checksum, exposing the build to MITM or supply chain attacks.
**Prevention:** Always download the official checksum file alongside the binary and verify it using `sha256sum -c` before installation.

## 2024-04-29 - Dynamic Dependency Checksum Downloading and GitHub API Calls
**Vulnerability:** Dependency installation scripts were fetching binaries and their checksum files dynamically during the build process, and using unauthenticated GitHub API calls to determine the "latest" versions.
**Learning:** This approach has two major flaws. First, dynamically downloading a checksum file from the same source as the binary defeats supply-chain security; if the source is compromised or a MITM attack occurs, the attacker can replace both the binary and the checksum. Second, unauthenticated GitHub API calls frequently hit rate limits in CI environments, leading to build failures.
**Prevention:** Always hardcode specific version numbers and their corresponding verified SHA256 checksums in the `Containerfile`. Use `echo "<hash>  <filename>" | sha256sum -c -` to verify the downloaded binary against the hardcoded hash before installation.
