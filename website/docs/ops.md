# OPS.md: Operations Runbook

## Target Hardware Manifest (Zero Compromises)
* **System:** Framework Laptop 13
* **Processor:** AMD Ryzen™ AI 300 Series - Ryzen™ AI 9 HX 370 (Zen 5, RDNA 3.5, XDNA 2 NPU)
* **Memory:** 96GB (2 x 48GB) DDR5-5600 (UMA maximized via BIOS for local LLM inference)
* **Storage:** 2TB WD_BLACK™ SN850X NVMe™ M.2 2280
* **Display:** 2.8K (2880x1920, 3:2 ratio - Wayland 150% fractional scaling defaults)
* **Expansion I/O:** USB-C, USB-A, HDMI (3rd Gen), and Ethernet.

## Local Validation
Before pushing changes to the repository, you can run the BATS test suite locally if you have `bats` and `podman` installed.

### Running Tests Locally
If you have already built the image locally:
```bash
podman run --rm localhost/bluefin-framework-antigravity:latest bats /tests/os_validation.bats
```

## Disaster Recovery

### Rolling Back
Since the OS is atomic, rolling back to a previous "known-good" version is straightforward:
```bash
rpm-ostree rollback
```

### Resetting Antigravity Workspace
If the AI quarantine environment becomes corrupted, you can delete the workspace and recreate it:
```bash
rm -rf ~/.local/share/antigravity-workspace
ujust setup-antigravity
```

## Maintenance

### Updating the Image
The image is rebuilt daily via GitHub Actions. To update your local system:
```bash
rpm-ostree upgrade
```

### Updating GitHub Actions
`dependabot` will automatically create Pull Requests for GitHub Action updates. Review and merge these weekly to ensure CI/CD security and stability.

## CI/CD Pipeline
The pipeline consists of:
1. **YAML Linting:** Ensures syntax correctness for all configuration and workflow files.
2. **BlueBuild:** Compiles the OCI image based on `recipes/recipe.yml`.
3. **BATS Validation:** Runs the `tests/os_validation.bats` suite against the newly built image.
4. **Cosign Signing:** Cryptographically signs the image if tests pass.
5. **Registry Push:** Publishes the signed image to `ghcr.io`.
