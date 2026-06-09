#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp "$SCRIPT_DIR/bashrc" "$HOME/.bashrc"
cp "$SCRIPT_DIR/bash_aliases" "$HOME/.bash_aliases"

source $HOME/.bashrc
