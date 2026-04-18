# TODO: bluefin-framework-antigravity Improvements

1. [x] Fix invalid `actions/checkout@v4` versioning (pinned to stable `v4`).
2. [x] Implement "Single Source of Truth" for documentation via MDX imports.
3. [x] Migrate Build Dashboard to Docusaurus build pipeline.
4. [x] Remove redundant `glib-compile-schemas` comments from `recipe.yml`.
5. [x] Update `distrobox.ini` to use declarative `additional_packages` for Chrome.
6. [x] Fix hardcoded repository URL in `website/src/components/Dashboard/index.tsx`.
7. [x] Add BATS test for `amd_pstate` kernel argument validation.
8. [x] Synchronize `tests/os_validation.bats` with the internal image copy.
9. [x] Resolve `cosign` version validation bug in `blue-build/github-action`.
10. [x] Standardize YAML document starts in all configuration and workflow files.
11. [x] Implement SLSA Build Provenance and Artifact Attestations.
12. [x] Complete Level 10 Performance Review.
13. [ ] Implement Antigravity ISO Forge (Phase 1-4)

## Additional CI/CD & Security Improvements
- [x] Expand Dependabot Coverage: Add npm ecosystem for `website/`.
- [x] Consolidate Chrome Installation: Use declarative `additional_packages` in `distrobox.ini`.
- [x] Add Formatting/Linting Scripts: Update `website/package.json` with Prettier/ESLint.
- [x] Use `$HOME` instead of `~`: Update paths in `distrobox.ini`.
- [x] Require YAML Document Starts: Enable `document-start` in `.yamllint.yml` and update files.
- [x] Recursive To-do Updates: Ensure the to-do list is updated at the end of every session.
- [ ] Implement Prettier/ESLint automation in CI.
- [ ] Expand BATS suite to include Homebrew/Flatpak policy validation.

## Documentation Improvements (Completed)
- [x] Restructure sidebar into logical categories (Introduction, Getting Started, Hardware, Usage, Technical Reference).
- [x] Create comprehensive 'Installation & Setup' guide.
- [x] Create detailed 'Hardware Optimization' page for Framework 13 Ryzen AI 300.
- [x] Create 'Quarantined AI (Antigravity)' guide explaining Distrobox and ROCm.
- [x] Create 'Software Management' policy guide (Flatpak/Homebrew).
- [x] Ensure SSOT via MDX imports for architecture, security, and ops.
