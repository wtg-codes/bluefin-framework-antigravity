## 2024-06-25 - Containerfile Binary Integrity Check Missing
**Vulnerability:** The Containerfile (`files/workspace/Containerfile`) was downloading the `kubectl` binary over the network and executing it as root without validating its integrity (CWE-494).
**Learning:** Containerfiles should not blindly install executables from raw network streams.
**Prevention:** Always securely download `.sha256` checksum files to verify the integrity of the downloaded executables using `sha256sum -c` to mitigate MITM and supply chain attacks.
