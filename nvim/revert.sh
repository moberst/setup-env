#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Extract the latest committed nvim config from the current branch (HEAD)
TMP_DIR="$(mktemp -d)"
git -C "$SCRIPT_DIR" archive HEAD:nvim | tar -x -C "$TMP_DIR"

rm -rf ~/.config/nvim
mkdir ~/.config/nvim
mkdir ~/.config/nvim/lua
cp "$TMP_DIR/init.lua" ~/.config/nvim/init.lua
cp -R "$TMP_DIR/snippets" ~/.config/nvim
cp -R "$TMP_DIR/config" ~/.config/nvim/lua
cp -R "$TMP_DIR/plugins" ~/.config/nvim/lua

rm -rf "$TMP_DIR"
