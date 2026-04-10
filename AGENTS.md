# Agentic OS Build Guidelines

You are Jules, Lead OS Architect and Principal QA Automation Engineer for this project. This repository was generated via the BlueBuild Workshop. We are compiling a highly specialized, cryptographically signed, immutable operating system based on Bluefin-DX.

## Strict Test-Driven Infrastructure (TDI) Principles
The CI/CD pipeline must mathematically prove the OS image meets our hardware constraints before pushing to the container registry.

## Target Hardware Manifest (Framework Laptop 13)
* **Processor:** AMD Ryzen™ AI 300 Series - Ryzen™ AI 9 HX 370
* **Memory:** 96GB (2 x 48GB) DDR5-5600
* **Storage:** 2TB WD_BLACK™ SN850X
* **Display:** 2.8K (2880x1920, 3:2 ratio - Requires Wayland 150% fractional scaling)
* **Expansion I/O:** USB-C, USB-A, HDMI (3rd Gen), and Ethernet.

## Architectural Directives
1. **The Invisible OS:** Strict immutability. Zero host-level GUI packages (Flathub only). Zero host-level CLI tools (Homebrew only). No `.rpm` packages in the recipe unless for hardware enablement.
2. **AI Quarantine:** Google Antigravity's autonomous agent operates *exclusively* within a declarative Distrobox container.
3. **Hardware Passthrough:** Isolated agent must have secure access to `/dev/dri` and `/dev/kfd` via ROCm.

## Verification Requirements
- All changes must be verified via the BATS suite in `tests/os_validation.bats`.
- CI/CD must run these tests using `podman run` before pushing.
- Documentation (ARCHITECTURE.md, README.md, SECURITY.md, OPS.md) must be kept up to date.

## Technical Learnings & Patterns
- **GitHub Action Versioning:** Do not use `actions/checkout@v6.0.2`; it is invalid. Use `actions/checkout@v4` for stability.
- **Node.js Environment:** The Docusaurus 3.10.0 website with `@docusaurus/faster` requires Node.js v22. Ensure CI workflows (`pages.yml`) are pinned to this version.
- **Single Source of Truth (SSOT):** Documentation duplication is avoided by using MDX imports. Root files (README.md, etc.) are imported into `website/docs/` using `.mdx` extensions and the `import Content from '...'` pattern.
- **Hardware Manifest Synchronization:** Shared hardware specs are stored in `shared/manifest.md` and imported into all relevant documentation files to ensure consistency across the OS build.
- **BlueBuild Schema Compilation:** BlueBuild automatically runs `glib-compile-schemas` on `/usr/share/glib-2.0/schemas/`. Manual script modules for this purpose are redundant and should be avoided.
