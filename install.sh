#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing rust and other utilities"
bash "$SCRIPT_DIR/install_scripts/install.sh"

echo "Configuring bash, git, starship, nvim"
bash "$SCRIPT_DIR/bash/configure.sh"
bash "$SCRIPT_DIR/git/configure.sh"
bash "$SCRIPT_DIR/starship/configure.sh"
bash "$SCRIPT_DIR/nvim/configure.sh"
