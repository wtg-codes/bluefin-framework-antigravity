#!/usr/bin/env bash
set -oue pipefail
export PIPX_HOME=/opt/pipx
export PIPX_BIN_DIR=/usr/local/bin
pipx install google-adk
