#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for script in "$SCRIPT_DIR"/install_*.sh; do
    [ -e "$script" ] || continue
    echo "==> Running $(basename "$script")"
    bash "$script"
done
