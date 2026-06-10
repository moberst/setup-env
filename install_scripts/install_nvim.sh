#!/usr/bin/env bash
set -euo pipefail

DEST="$HOME/.neovim"

# Tracks the "latest" release, so we can't version-check cheaply; install once
# and skip on subsequent runs. Delete ~/.neovim to force a refresh.
if [ -x "$DEST/bin/nvim" ]; then
    echo "neovim already installed at $DEST, skipping"
    exit 0
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

ARCHIVE="nvim-linux-x86_64.tar.gz"
wget -q -O "$TMP/$ARCHIVE" \
    "https://github.com/neovim/neovim/releases/latest/download/${ARCHIVE}"
tar xzf "$TMP/$ARCHIVE" -C "$TMP"

# rm -rf guards against a stale/corrupt dir (e.g. from an earlier mv-into-dir
# bug); without it `mv` would nest the new tree inside the existing one.
rm -rf "$DEST"
mv "$TMP/nvim-linux-x86_64" "$DEST"
echo "Installed neovim to $DEST"
