# wtgOS 🐟🚀

[![bluebuild build badge](https://github.com/wtg-codes/bluefin-framework-antigravity/actions/workflows/build.yml/badge.svg)](https://github.com/wtg-codes/bluefin-framework-antigravity/actions/workflows/build.yml)
[![GitHub Pages](https://img.shields.io/badge/Dashboard-GitHub%20Pages-blue)](https://wtg-codes.github.io/bluefin-framework-antigravity/)

Welcome to the future, friends! **wtgOS** is a custom, opinionated, cloud-native developer appliance based on [Project Bluefin-DX](https://projectbluefin.io) + Google dev tools. We treat the desktop like cattle, not pets—featuring a read-only root filesystem, automated updates, and zero host-level pollution.

> [!TIP]
> **View the [Live Documentation & Dashboard](https://wtg-codes.github.io/bluefin-framework-antigravity/) for build status, latest images, and setup guides.**

## 📥 Installation

### Option 1: The "Bluefin Way" (Rebase)
If you are already running a Fedora Atomic / uBlue installation, just open your terminal and run:

```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/wtg-codes/bluefin-framework-antigravity:latest
```
Then reboot!

### Option 2: Clean Install (Bare Metal)
Head over to the [Releases](../../releases) page and download the latest `.iso` file. Flash it to a USB drive using BalenaEtcher or Fedora Media Writer.

## 🚀 The Cloud-Native Laboratory
wtgOS is built for **Cloud-Native Computing students** and **Multi-Agent Systems orchestration**.

- **Immutable Host:** The host OS exists only to run containers and hardware drivers. No host-level SDKs!
- **Declarative Workspace:** All student development happens inside a high-performance Distrobox (`wtg-workspace`) baked with `kubectl`, `helm`, `k9s`, `kind`, and Google dev tools.
- **AI Quarantine:** Isolated AI agent execution with direct hardware passthrough (ROCm) for GPU/NPU workloads.
- **Zero-Trust CI/CD:** Every image is cryptographically signed and every ISO is verified before publication.

## 🛠️ Student Quick Start
Once you have booted into wtgOS, bootstrap your workspace:

```bash
ujust setup-workspace
ujust start-cluster
```

## 📖 Technical Reference
- 🛠️ **[Architecture (ADRs)](https://wtg-codes.github.io/bluefin-framework-antigravity/docs/architecture)**
- 🛡️ **[Security Model](https://wtg-codes.github.io/bluefin-framework-antigravity/docs/security)**
- 📖 **[Operations Runbook](https://wtg-codes.github.io/bluefin-framework-antigravity/docs/ops)**

## 🤝 Upstream First
This project stands on the shoulders of giants. If you find a bug in the desktop environment, please report it to [Fedora](https://fedoraproject.org/) or [GNOME](https://gnome.org/).

---
Built with ❤️ using [BlueBuild](https://blue-build.org).
