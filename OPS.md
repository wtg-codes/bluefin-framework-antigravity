# OPS.md: Operations Runbook

## Local Validation
Before pushing changes to the repository, you can run the BATS test suite locally if you have `bats` and `podman` installed.

### Running Tests Locally
If you have already built the image locally:
```bash
podman run --rm <your_image_name> bats /tests/os_validation.bats
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
