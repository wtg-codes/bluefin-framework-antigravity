---
sidebar_position: 3
---

# OPS.md: Operations & Lifecycle Management

## Continuous Deployment
This repository uses a fully automated CI/CD pipeline.
*   **Daily Builds:** The OS image is rebuilt every day at 06:00 UTC to pull in the latest upstream security updates from Bluefin and Fedora.
*   **On-Push Deployment:** Any changes to the `recipe.yml`, `modules/`, or `files/` directories trigger an immediate build and push to the GitHub Container Registry (GHCR).
*   **Documentation Updates:** The [GitHub Pages site](https://wtg-codes.github.io/bluefin-framework-antigravity/) is automatically updated whenever the image build succeeds or documentation files are modified.

## System Maintenance
Since this is an immutable OS, standard maintenance tasks are handled differently:
*   **Updates:** Updates are downloaded in the background. To apply them, simply reboot your system.
*   **Rollbacks:** If an update causes issues, you can easily rollback to the previous version from the GRUB menu or by running:
    ```bash
    rpm-ostree rollback
    ```
*   **Health Checks:** The `ujust setup-antigravity` command can be re-run at any time to verify the state of your AI quarantine environment and hardware passthrough configuration.

## Hardware Validation
The BATS test suite at `tests/os_validation.bats` is the source of truth for system health. It validates:
*   Kernel arguments (`amd_pstate`, `amdgpu`).
*   Systemd service status.
*   Hardware availability (`/dev/dri`, `/dev/kfd`).
*   Immutability constraints.

## Monitoring
Refer to the [System Dashboard](https://wtg-codes.github.io/bluefin-framework-antigravity/dashboard) for the current status of the latest image builds, including duration, success/failure logs, and commit metadata.
