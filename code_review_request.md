This pull request aims to fix three separate CI/CD issues:
1. Fixes `.yamllint.yml` to properly ignore `node_modules/` and `website/node_modules/` which caused the `lint` job to fail.
2. Updates `recipes/recipe.yml` `default-flatpaks` module schema to match the `system` syntax rather than `configurations`, which was preventing the image from building successfully.
3. Swaps imperative shell package installations in `recipes/recipe.yml` (e.g. `npm install ...` via `script`) to declarative `brew` modules.
4. Adds `extra_squeeze: true` to `.github/workflows/build.yml` for the `bluebuild` action to mitigate `No space left on device` errors when building `bluefin-dx`.
