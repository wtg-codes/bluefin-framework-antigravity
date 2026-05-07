## 2024-05-07 - Refactoring Host OS Repository to align with Bluefin-DX
**Learning:** Understanding Bluebuild's gschema-overrides module. The module expects override files to be stored in `files/gschema-overrides/` and included in the `recipe.yml` using the file name rather than the path (e.g. `zz1-org.gnome.mutter.gschema.override`).
**Action:** When updating the gschema-overrides, the file must be moved to `files/gschema-overrides/` and prefixed with `zz1-` or a similar prefix for alphabetic precedence, and the `recipe.yml` file should be updated to refer to the file instead of a path.
