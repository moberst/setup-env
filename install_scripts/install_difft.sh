#!/usr/bin/env bash
set -euo pipefail

VERSION="0.69.0"
DEST="$HOME/.local/bin"
TARGET="$DEST/difft"

if [ -x "$TARGET" ] && "$TARGET" --version 2>/dev/null | grep -qF "$VERSION"; then
    echo "difft $VERSION already installed, skipping"
    exit 0
fi

mkdir -p "$DEST"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

ARCHIVE="difft-x86_64-unknown-linux-gnu.tar.gz"
wget -q -O "$TMP/$ARCHIVE" \
    "https://github.com/Wilfred/difftastic/releases/download/${VERSION}/${ARCHIVE}"
tar xzf "$TMP/$ARCHIVE" -C "$TMP"
mv "$TMP/difft" "$TARGET"
chmod +x "$TARGET"
echo "Installed difft $VERSION"
