---
sidebar_position: 1
---

# bluefin-framework-antigravity

[![bluebuild build badge](https://github.com/wtg-codes/bluefin-framework-antigravity/actions/workflows/build.yml/badge.svg)](https://github.com/wtg-codes/bluefin-framework-antigravity/actions/workflows/build.yml)
[![GitHub Pages](https://img.shields.io/badge/Docs-GitHub%20Pages-blue)](https://wtg-codes.github.io/bluefin-framework-antigravity/)

**bluefin-framework-antigravity** is a highly specialized, cryptographically signed, immutable operating system based on Bluefin-DX, optimized for the Framework Laptop 13 and agentic development workflows.

> [!IMPORTANT]
> **View the [Official Documentation & Dashboard](https://wtg-codes.github.io/bluefin-framework-antigravity/) for build status, latest images, and installation guides.**

## Features
- **Strict Immutability:** Zero host-level GUI/CLI tools (Flathub/Homebrew only).
- **AI Quarantine:** Antigravity agent operates in a declarative Distrobox container.
- **Hardware Passthrough:** ROCm access for GPU/NPU-accelerated AI workloads.
- **TDI Validated:** CI/CD pipeline enforces hardware and configuration constraints via BATS before every push.

## Target Hardware Manifest
* **System:** Framework Laptop 13
* **Processor:** AMD Ryzen™ AI 300 Series - Ryzen™ AI 9 HX 370
* **Memory:** 96GB DDR5-5600
* **Storage:** 2TB NVMe™
* **Display:** 2.8K (2880x1920, 3:2 ratio)

## Installation

### 1. Rebase to the image
```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/wtg-codes/bluefin-framework-antigravity:latest
```

### 2. Reboot and Initialize
```bash
ujust setup-antigravity
```

Full instructions available on the [Documentation Site](https://wtg-codes.github.io/bluefin-framework-antigravity/docs/intro).
