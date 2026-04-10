# bluefin-framework-antigravity

[![bluebuild build badge](https://github.com/wtg-codes/bluefin-framework-antigravity/actions/workflows/build.yml/badge.svg)](https://github.com/wtg-codes/bluefin-framework-antigravity/actions/workflows/build.yml)
[![GitHub Pages](https://img.shields.io/badge/Dashboard-GitHub%20Pages-blue)](https://wtg-codes.github.io/bluefin-framework-antigravity/)

**bluefin-framework-antigravity** is a highly specialized, cryptographically signed, immutable operating system based on Bluefin-DX, optimized for the Framework Laptop 13 and agentic development workflows.

> [!TIP]
> **View the [Live Dashboard](https://wtg-codes.github.io/bluefin-framework-antigravity/docs/dashboard) for build status, latest images, and detailed installation guides.**

## Documentation
- 🛠️ **[Architecture (ADRs)](https://wtg-codes.github.io/bluefin-framework-antigravity/docs/architecture)** - Architectural Decision Records and system design.
- 🛡️ **[Security Model](https://wtg-codes.github.io/bluefin-framework-antigravity/docs/security)** - Threat model and mitigation strategies.
- 📖 **[Operations Runbook](https://wtg-codes.github.io/bluefin-framework-antigravity/docs/ops)** - Maintenance, updates, and disaster recovery.
- 💻 **[Hardware Manifest](https://wtg-codes.github.io/bluefin-framework-antigravity/docs/intro#target-hardware-manifest-zero-compromises)** - Detailed hardware specifications.

## Target Hardware Manifest (Zero Compromises)
import Manifest from './shared/manifest.md';

<Manifest />

## Features
- **Strict Immutability:** Zero host-level GUI/CLI tools (Flathub/Homebrew only).
- **AI Quarantine:** Antigravity agent operates in a declarative Distrobox container.
- **Hardware Passthrough:** ROCm access for GPU/NPU-accelerated AI workloads.
- **TDI Validated:** CI/CD pipeline enforces hardware and configuration constraints via BATS before every push.

## Quick Start

1. **Rebase to the image**:
   ```bash
   rpm-ostree rebase ostree-unverified-registry:ghcr.io/wtg-codes/bluefin-framework-antigravity:latest
   ```
2. **Reboot and Initialize**:
   ```bash
   ujust setup-antigravity
   ```

Full instructions available on the [Documentation Site](https://wtg-codes.github.io/bluefin-framework-antigravity/docs/intro).
