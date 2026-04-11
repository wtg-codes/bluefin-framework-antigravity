# SECURITY.md: Threat Model and Mitigation

## Target Hardware Manifest (Zero Compromises)
import Manifest from './shared/manifest.md';

<Manifest />

## Threat Model

### T1: Host System Compromise via AI Hallucination
*   **Threat:** An AI agent executing code might hallucinate destructive `sudo` commands or attempt to modify system-level configurations.
*   **Mitigation:** The AI agent operates within a **Distrobox container** with a non-privileged user and a mapped workspace (`~/.local/share/antigravity-workspace`). The **atomic root filesystem** is read-only, preventing any accidental or malicious modification of the host OS even if the agent attempts to use `sudo`.

### T2: Supply Chain Attack
*   **Threat:** Malicious code injected into the OS image during the build process.
*   **Mitigation:**
    *   **Cryptographic Signing:** Every build is signed using `cosign` and the keys are managed via GitHub Secrets.
    *   **SLSA Build Provenance:** We implement **SLSA Build Provenance and Artifact Attestations** via `actions/attest-build-provenance`. This provides a cryptographically verifiable link between the final OCI image and the specific GitHub Action run that produced it.
    *   **Automated Dependency Updates:** `dependabot` is configured to scan and update GitHub Actions and the `npm` ecosystem for the documentation site weekly, ensuring all upstream components are current.
    *   **Automated Updates:** The `pull` app (if configured) ensures that upstream components are kept up-to-date with the latest security patches.

### T3: Unauthorized Hardware Access
*   **Threat:** Isolated containers accessing hardware they shouldn't.
*   **Mitigation:** Hardware passthrough is explicitly limited to `/dev/dri` and `/dev/kfd` via the declarative `distrobox.ini`, ensuring the agent can only access the GPU/NPU for acceleration while remaining isolated from other system-level devices.

## Immutability as a Security Feature
The decision to use a strictly immutable host (`bluefin-dx`) with zero host-level CLI/GUI packages minimizes the attack surface. Any development tool or agent must exist within a container, ensuring that the core OS remains in a "known-good" state at all times. Our Test-Driven Infrastructure (TDI) mathematically proves these security constraints are met before any image is published.
