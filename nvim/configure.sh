#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

rm -rf ~/.config/nvim
mkdir ~/.config/nvim
mkdir ~/.config/nvim/lua
cp "$SCRIPT_DIR/init.lua" ~/.config/nvim/init.lua
cp -R "$SCRIPT_DIR/snippets" ~/.config/nvim
cp -R "$SCRIPT_DIR/config" ~/.config/nvim/lua
cp -R "$SCRIPT_DIR/plugins" ~/.config/nvim/lua

if [ -d ~/.config/obsidian-templates ]; then
  rm -rf ~/.config/obsidian-templates
fi
cp -R "$SCRIPT_DIR/obsidian-templates" ~/.config

