# bluefin-framework-antigravity

[![bluebuild build badge](https://github.com/wtg-codes/bluefin-framework-antigravity/actions/workflows/build.yml/badge.svg)](https://github.com/wtg-codes/bluefin-framework-antigravity/actions/workflows/build.yml)
[![yaml-lint badge](https://github.com/wtg-codes/bluefin-framework-antigravity/actions/workflows/yaml-lint.yml/badge.svg)](https://github.com/wtg-codes/bluefin-framework-antigravity/actions/workflows/yaml-lint.yml)

**bluefin-framework-antigravity** is a highly specialized, cryptographically signed, immutable operating system based on Bluefin-DX, optimized for the Framework Laptop 13 and agentic development workflows.

## Target Hardware Manifest (Zero Compromises)
* **System:** Framework Laptop 13
* **Processor:** AMD Ryzen™ AI 300 Series - Ryzen™ AI 9 HX 370 (Zen 5, RDNA 3.5, XDNA 2 NPU)
* **Memory:** 96GB (2 x 48GB) DDR5-5600 (UMA maximized via BIOS for local LLM inference)
* **Storage:** 2TB WD_BLACK™ SN850X NVMe™ M.2 2280
* **Display:** 2.8K (2880x1920, 3:2 ratio - Wayland 150% fractional scaling defaults)
* **Expansion I/O:** USB-C, USB-A, HDMI (3rd Gen), and Ethernet.

## Features
- **Strict Immutability:** Zero host-level GUI/CLI tools (Flathub/Homebrew only).
- **AI Quarantine:** Antigravity agent operates in a declarative Distrobox container.
- **Hardware Passthrough:** ROCm access for GPU/NPU-accelerated AI workloads.
- **TDI Validated:** CI/CD pipeline enforces hardware and configuration constraints via BATS before every push.

## Installation

To rebase an existing atomic Fedora installation to this image:

1. **Rebase to the unsigned image** (installs signing keys and policies):
   ```bash
   rpm-ostree rebase ostree-unverified-registry:ghcr.io/wtg-codes/bluefin-framework-antigravity:latest
   ```
2. **Reboot**:
   ```bash
   systemctl reboot
   ```
3. **Rebase to the signed image**:
   ```bash
   rpm-ostree rebase ostree-image-signed:docker://ghcr.io/wtg-codes/bluefin-framework-antigravity:latest
   ```
4. **Reboot**:
   ```bash
   systemctl reboot
   ```

## Setup Antigravity AI Quarantine

After installation, initialize the isolated AI environment:

```bash
ujust setup-antigravity
```

## Verification

The image is signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). Verify the signature:

```bash
cosign verify --key cosign.pub ghcr.io/wtg-codes/bluefin-framework-antigravity
```
