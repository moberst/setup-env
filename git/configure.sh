#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p ~/.config/lazygit
cp "$SCRIPT_DIR/gitconfig.yml" ~/.gitconfig
cp "$SCRIPT_DIR/lazygit_config.yml" ~/.config/lazygit/config.yml
