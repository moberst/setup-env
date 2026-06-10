#!/usr/bin/env bash
set -euo pipefail

VERSION="0.72.0"
DEST="$HOME/.local/bin"
TARGET="$DEST/fzf"

if [ -x "$TARGET" ] && "$TARGET" --version 2>/dev/null | grep -qF "$VERSION"; then
    echo "fzf $VERSION already installed, skipping"
    exit 0
fi

mkdir -p "$DEST"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

ARCHIVE="fzf-${VERSION}-linux_amd64.tar.gz"
wget -q -O "$TMP/$ARCHIVE" \
    "https://github.com/junegunn/fzf/releases/download/v${VERSION}/${ARCHIVE}"
tar xzf "$TMP/$ARCHIVE" -C "$TMP"
mv "$TMP/fzf" "$TARGET"
chmod +x "$TARGET"
echo "Installed fzf $VERSION"
