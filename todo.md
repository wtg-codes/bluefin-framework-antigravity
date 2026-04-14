# TODO: bluefin-framework-antigravity Improvements

1. [x] Fix invalid `actions/checkout@v6.0.2` in `build.yml` (pinned to `v4`).
2. [x] Implement "Single Source of Truth" for documentation via MDX imports.
3. [x] Migrate Build Dashboard to Docusaurus build pipeline.
4. [x] Remove redundant `glib-compile-schemas` comments from `recipe.yml`.
5. [ ] Update `distrobox.ini` to use declarative `additional_packages` for Chrome.
6. [ ] Fix hardcoded repository URL in `website/src/pages/dashboard.tsx`.
7. [ ] Add BATS test for `amd_pstate` kernel argument validation.
8. [ ] Synchronize `tests/os_validation.bats` with the internal image copy.
9. [x] Resolve `cosign` version validation bug in `blue-build/github-action`.
10. [ ] Standardize YAML indentation in all workflow files.
11. [x] Implement SLSA Build Provenance and Artifact Attestations.
12. [ ] Implement Antigravity ISO Forge (Phase 1-4)

## Additional CI/CD & Security Improvements
- [x] Expand Dependabot Coverage: Add npm ecosystem for `website/`.
- [ ] Consolidate Chrome Installation: Use declarative `additional_packages` in `distrobox.ini`.
- [ ] Add Formatting/Linting Scripts: Update `website/package.json` with Prettier/ESLint.
- [ ] Use `$HOME` instead of `~`: Update paths in `distrobox.ini`.
- [ ] Require YAML Document Starts: Enable `document-start` in `.yamllint.yml` and update files.
- [ ] Fix hardcoded Dashboard URL: Pull dynamically from Docusaurus config (resolves item #6).
- [ ] Recursive To-do Updates: Ensure the to-do list is updated at the end of every session.

## Documentation Improvements (Completed)
- [x] Restructure sidebar into logical categories (Introduction, Getting Started, Hardware, Usage, Technical Reference).
- [x] Create comprehensive 'Installation & Setup' guide.
- [x] Create detailed 'Hardware Optimization' page for Framework 13 Ryzen AI 300.
- [x] Create 'Quarantined AI (Antigravity)' guide explaining Distrobox and ROCm.
- [x] Create 'Software Management' policy guide (Flatpak/Homebrew).
- [x] Ensure SSOT via MDX imports for architecture, security, and ops.
