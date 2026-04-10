# TODO: bluefin-framework-antigravity Improvements

1. [x] Fix invalid `actions/checkout@v6.0.2` in `build.yml` (pinned to `v4`).
2. [x] Implement "Single Source of Truth" for documentation via MDX imports.
3. [x] Migrate Build Dashboard to Docusaurus build pipeline.
4. [ ] Remove redundant `glib-compile-schemas` comments from `recipe.yml`.
5. [ ] Update `distrobox.ini` to use declarative `additional_packages` for Chrome.
6. [ ] Fix hardcoded repository URL in `website/src/pages/dashboard.tsx`.
7. [ ] Add BATS test for `amd_pstate` kernel argument validation.
8. [ ] Synchronize `tests/os_validation.bats` with the internal image copy.
9. [ ] Resolve `cosign` version validation bug in `blue-build/github-action`.
10. [ ] Standardize YAML indentation in all workflow files.
