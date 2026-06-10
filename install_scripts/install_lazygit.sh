#!/usr/bin/env bash
set -euo pipefail

VERSION="0.61.1"
DEST="$HOME/.local/bin"
TARGET="$DEST/lazygit"

if [ -x "$TARGET" ] && "$TARGET" --version 2>/dev/null | grep -qF "version=$VERSION"; then
    echo "lazygit $VERSION already installed, skipping"
    exit 0
fi

mkdir -p "$DEST"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

ARCHIVE="lazygit_${VERSION}_linux_x86_64.tar.gz"
wget -q -O "$TMP/$ARCHIVE" \
    "https://github.com/jesseduffield/lazygit/releases/download/v${VERSION}/${ARCHIVE}"
tar xzf "$TMP/$ARCHIVE" -C "$TMP"
mv "$TMP/lazygit" "$TARGET"
chmod +x "$TARGET"
echo "Installed lazygit $VERSION"
