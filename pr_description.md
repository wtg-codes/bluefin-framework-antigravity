Fixes several CI issues that prevented the project from building successfully:
- Fixes `yamllint` errors by ignoring `node_modules` folders.
- Fixes `bluebuild` out of disk space errors by using the `extra_squeeze: true` option on github-action.
- Fixes `default-flatpaks` module schema syntax in `recipes/recipe.yml`.
- Shifts from imperative `script` commands to declarative `brew` modules in `recipes/recipe.yml`.
