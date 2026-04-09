# ARCHITECTURE.md: Agentic OS Build

## Target Hardware Manifest (Zero Compromises)
* **System:** Framework Laptop 13
* **Processor:** AMD Ryzen™ AI 300 Series - Ryzen™ AI 9 HX 370 (Zen 5, RDNA 3.5, XDNA 2 NPU)
* **Memory:** 96GB (2 x 48GB) DDR5-5600 (UMA maximized via BIOS for local LLM inference)
* **Storage:** 2TB WD_BLACK™ SN850X NVMe™ M.2 2280
* **Display:** 2.8K (2880x1920, 3:2 ratio - Wayland 150% fractional scaling defaults)
* **Expansion I/O:** USB-C, USB-A, HDMI (3rd Gen), and Ethernet.

## Architectural Decision Records (ADR)

### ADR 1: Quarantined AI Workflow
**Context:** We need a highly specialized environment for AI development that avoids polluting the host filesystem with large LLM dependencies or development libraries.
**Decision:** We use `distrobox` to create a declarative Ubuntu 24.04 FHS container.
**Rationale:** This ensures that AI agents (like Google Antigravity) operate in an isolated environment while having full access to required libraries and a dedicated workspace at `~/.local/share/antigravity-workspace`.

### ADR 2: ROCm Hardware Passthrough
**Context:** Local LLM inference requires significant GPU resources and memory access. The target hardware (Framework 13 with Ryzen AI 300 series) has 96GB of memory with an XDNA 2 NPU and RDNA 3.5 graphics.
**Decision:** We explicitly pass `/dev/dri` and `/dev/kfd` into the Distrobox container.
**Rationale:** This allows the quarantined AI agent to leverage the full 96GB memory pool via ROCm (Radeon Open Compute) for local inference without compromising host security or immutability.

### ADR 3: BlueBuild Workshop for SLSA Level 3
**Context:** Security is paramount for an immutable OS.
**Decision:** We use the BlueBuild Workshop to automate the creation of the repository, including automated container signing with `cosign`.
**Rationale:** This ensures our OS images are cryptographically signed and meet SLSA Level 3 standards for supply chain security.

### ADR 4: Kernel Tuning for Framework 13
**Context:** The Framework 13 with Ryzen AI 300 series requires specific kernel parameters for optimal power management and display stability.
**Decision:** We append `amd_pstate=active` and `amdgpu.sg_display=0` to the kernel arguments.
**Rationale:** `amd_pstate=active` enables the modern AMD P-state driver for better performance/efficiency, and `amdgpu.sg_display=0` addresses specific display issues with the 2.8K panel.

### ADR 5: Test-Driven Infrastructure (TDI)
**Context:** Changes to the OS must be verified before deployment.
**Decision:** Implement a BATS test suite that runs against the built OCI image in the CI pipeline.
**Rationale:** This provides mathematical proof that the OS meets hardware and configuration constraints before pushing to the container registry, preventing regressions in hardware enablement or security policies.
