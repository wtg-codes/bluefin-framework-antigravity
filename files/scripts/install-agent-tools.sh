#!/usr/bin/env bash
set -oue pipefail

echo "Installing AI Agent Dependencies..."
npm install -g @google/gemini-cli || echo "npm not found, skipping..."
pipx install google-adk || echo "pipx not found, skipping..."
