# SECURITY.md: Threat Model and Mitigation

## Target Hardware Manifest (Zero Compromises)
* **System:** Framework Laptop 13
* **Processor:** AMD Ryzen™ AI 300 Series - Ryzen™ AI 9 HX 370 (Zen 5, RDNA 3.5, XDNA 2 NPU)
* **Memory:** 96GB (2 x 48GB) DDR5-5600 (UMA maximized via BIOS for local LLM inference)
* **Storage:** 2TB WD_BLACK™ SN850X NVMe™ M.2 2280
* **Display:** 2.8K (2880x1920, 3:2 ratio - Wayland 150% fractional scaling defaults)
* **Expansion I/O:** USB-C, USB-A, HDMI (3rd Gen), and Ethernet.

## Threat Model

### T1: Host System Compromise via AI Hallucination
*   **Threat:** An AI agent executing code might hallucinate destructive `sudo` commands or attempt to modify system-level configurations.
*   **Mitigation:** The AI agent operates within a **Distrobox container** with a non-privileged user and a mapped workspace (`~/.local/share/antigravity-workspace`). The **atomic root filesystem** is read-only, preventing any accidental or malicious modification of the host OS even if the agent attempts to use `sudo`.

### T2: Supply Chain Attack
*   **Threat:** Malicious code injected into the OS image during the build process.
*   **Mitigation:**
    *   **Cryptographic Signing:** Every build is signed using `cosign` and the keys are managed via GitHub Secrets.
    *   **SLSA Level 3 Compliance:** The build process is automated via BlueBuild Workshop, ensuring a transparent and verifiable supply chain.
    *   **Automated Updates:** `dependabot` and `pull` apps ensure that all upstream components and GitHub Actions are kept up-to-date with the latest security patches.

### T3: Unauthorized Hardware Access
*   **Threat:** Isolated containers accessing hardware they shouldn't.
*   **Mitigation:** Hardware passthrough is explicitly limited to `/dev/dri` and `/dev/kfd` via the declarative `distrobox.ini`, ensuring the agent can only access the GPU/NPU for acceleration while remaining isolated from other system-level devices.

## Immutability as a Security Feature
The decision to use a strictly immutable host (`bluefin-dx`) with zero host-level CLI/GUI packages minimizes the attack surface. Any development tool or agent must exist within a container, ensuring that the core OS remains in a "known-good" state at all times. Our Test-Driven Infrastructure (TDI) mathematically proves these security constraints are met before any image is published.
