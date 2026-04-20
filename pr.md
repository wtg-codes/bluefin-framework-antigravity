This pull request addresses several issues in the CI/CD pipeline preventing the build from passing:
1. `yamllint` checks were failing because dependency file folders (`node_modules/` and `website/node_modules/`) were not ignored.
2. The GitHub action runner was running out of disk space during the massive image build process.
3. The `recipe.yml` failed schema validations due to outdated `default-flatpaks` configurations.
4. Imperative shell script installations in `recipe.yml` were used over declarative module setups.

The fixes entail configuring `.yamllint.yml` to ignore dependency files, adding `extra_squeeze: true` to the `.github/workflows/build.yml` to mitigate the low disk space error, updating the flatpak installation schema to conform to modern formats, and replacing manual `npm` and `pipx` scripts with the official `brew` module.

Note: The ISO build process intentionally skips pull requests via the `if: github.event_name != 'pull_request'` condition in `.github/workflows/build.yml`. It will automatically trigger when this code is merged into `main` or it can be manually dispatched.
