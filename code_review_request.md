# Code Review Request: Security & Performance Documentation and Dependabot Expansion

## Changes
1. **Dependabot Expansion**: Added `npm` ecosystem scanning for the `website/` directory in `.github/dependabot.yml`.
2. **Security Documentation**: Updated `SECURITY.md` with details on SLSA Build Provenance, artifact attestations, and automated dependency updates.
3. **Operations & Performance Documentation**: Updated `OPS.md` with a new "Performance Optimizations" section detailing kernel arguments (`amd_pstate`, `amdgpu.sg_display`) and the Docusaurus Rspack build system (`@docusaurus/faster`).
4. **Task Tracking**: Updated `todo.md` to reflect the completed work.

## Verification
- Manual inspection of updated files.
- Verified presence of security/performance configurations in source code (`recipe.yml`, `build.yml`, `package.json`).
- (BATS tests and Yamllint were skipped due to tool unavailability in the environment).

Please review the documentation clarity and the Dependabot configuration.
