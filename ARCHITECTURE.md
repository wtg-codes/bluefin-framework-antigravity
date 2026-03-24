# ARCHITECTURE.md: Agentic OS Build

## Architectural Decision Records (ADR)

### ADR 1: Quarantined AI Workflow
**Context:** We need a highly specialized environment for AI development that avoids polluting the host filesystem with large LLM dependencies or development libraries.
**Decision:** We use `distrobox` to create a declarative Ubuntu 24.04 FHS container.
**Rationale:** This ensures that AI agents (like Google Antigravity) operate in an isolated environment while having full access to required libraries and a dedicated workspace at `~/.local/share/antigravity-workspace`.

### ADR 2: ROCm Hardware Passthrough
**Context:** Local LLM inference requires significant GPU resources and memory access. The target hardware (Framework 13 with Ryzen AI 9) has 96GB of memory with an XDNA 2 NPU and RDNA 3.5 graphics.
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
