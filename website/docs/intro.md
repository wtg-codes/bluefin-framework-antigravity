# Introduction

**bluefin-framework-antigravity** is a highly specialized, cryptographically signed, immutable operating system based on Bluefin-DX, optimized for the Framework Laptop 13 and agentic development workflows.

## Features
- **Strict Immutability:** Zero host-level GUI/CLI tools (Flathub/Homebrew only).
- **AI Quarantine:** Antigravity agent operates in a declarative Distrobox container.
- **Hardware Passthrough:** ROCm access for GPU/NPU-accelerated AI workloads.
- **TDI Validated:** CI/CD pipeline enforces hardware and configuration constraints via BATS before every push.

## Target Hardware Manifest (Zero Compromises)
* **System:** Framework Laptop 13
* **Processor:** AMD Ryzen™ AI 300 Series - Ryzen™ AI 9 HX 370 (Zen 5, RDNA 3.5, XDNA 2 NPU)
* **Memory:** 96GB (2 x 48GB) DDR5-5600 (UMA maximized via BIOS for local LLM inference)
* **Storage:** 2TB WD_BLACK™ SN850X NVMe™ M.2 2280
* **Display:** 2.8K (2880x1920, 3:2 ratio - Wayland 150% fractional scaling defaults)
* **Expansion I/O:** USB-C, USB-A, HDMI (3rd Gen), and Ethernet.

## Build Visualization
![System Build Visualization](/img/screenshot.png)
