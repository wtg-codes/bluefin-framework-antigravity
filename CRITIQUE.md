# Critique of `.jules/setup.sh`

Based on the environment requirements and project directives specified in `AGENTS.md` and repo memories, the current `.jules/setup.sh` script has several notable shortcomings:

## 1. Node.js Version Mismatch
- **Current State**: The setup script relies on whatever default Node.js version is present on the Jules VM (currently Node v22.22.1).
- **Issue**: `AGENTS.md` strictly dictates that the Docusaurus 3.10.0 website with `@docusaurus/faster` requires **Node.js v24**.
- **Fix**: The script must explicitly load NVM (which is available on the host) and run `nvm install 24 && nvm use 24`.

## 2. Missing AI Agent Dependencies
- **Current State**: Step 3 is just an `echo` statement ("🤖 Setting up Google ADK and Gemini CLI..."), but no actual installation commands are present.
- **Issue**: The agent cannot interact with the required AI tools locally, despite the script claiming to mirror `files/workspace/Containerfile`.
- **Fix**: The script needs to run `npm install -g @google/gemini-cli` and `pipx install google-adk`. This also implies `pipx` must be installed first if it isn't available.

## 3. Missing System Linting Dependencies
- **Current State**: The script installs `bats`, `curl`, and `jq`, but misses YAML linting tools.
- **Issue**: The project repository contains a `.yamllint.yml` file and requires validating configurations. Jules needs `yamllint` installed to verify declarative OS configs.
- **Fix**: Install `yamllint` (e.g., via `pipx` or `apt-get`).

## 4. Inefficient Execution Paths
- **Current State**: The Docusaurus installation changes directories (`cd website`, `npm ci`, `cd ..`).
- **Issue**: Directory traversal can lead to fragile scripts if an error occurs mid-execution, although mitigated slightly by `set -e`.
- **Fix**: Use `npm ci --prefix website` to maintain directory stability as suggested by project memories.

## Conclusion
The script correctly identifies the necessary tools but fails to fully provision the runtime. Fixing these issues will align the local VM precisely with the requirements specified for the CI/CD pipeline and the `wtgOS` environment.
