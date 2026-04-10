---
sidebar_position: 4
---

# SECURITY.md: Bluefin Framework Antigravity

## Core Security Tenets
1.  **Strict Immutability:** The host operating system is cryptographically signed and immutable. All user-installed GUI applications MUST be installed via **Flathub**, and CLI tools MUST be installed via **Homebrew**. No modifications are permitted on the host filesystem outside of explicitly designated stateful areas (`/var`, `/etc`).
2.  **AI Quarantine:** All agentic AI workloads (e.g., Google Antigravity) are strictly quarantined within a declarative **Distrobox** container (Ubuntu 24.04). The agent does not have write access to the host `/home` directory; it operates within a dedicated workspace at `~/.local/share/antigravity-workspace`.
3.  **Cryptographic Signing:** Every OS image is automatically signed using **Sigstore/Cosign** during the CI build process. Users can verify the integrity of the image using the public key provided in the [Official Dashboard](https://wtg-codes.github.io/bluefin-framework-antigravity/dashboard).
4.  **Hardware-Level Security:** The build is optimized for Framework Laptop 13, leveraging hardware-backed security features like TPM 2.0 and Secure Boot.

## Vulnerability Reporting
If you discover a security vulnerability, please do NOT open a public issue. Instead, email our security team at [security@wtg.example.com](mailto:security@wtg.example.com). We aim to acknowledge all reports within 48 hours and provide a resolution or mitigation strategy within 14 days.

## Supply Chain Integrity
Our CI/CD pipeline, powered by **BlueBuild**, enforces strict linting and BATS-based validation of all OS configuration changes. Every push to the main branch triggers a full build and validation cycle, ensuring that only verified, stable, and secure images are published to the container registry.
