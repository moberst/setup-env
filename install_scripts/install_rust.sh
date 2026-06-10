#!/usr/bin/env bash
set -euo pipefail

# Install rustup/cargo if not already present.
if [ ! -d "$HOME/.cargo" ] || ! command -v rustup >/dev/null 2>&1; then
    echo "Installing rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
    echo "rustup already installed, skipping"
fi

# shellcheck disable=SC1091
source "$HOME/.cargo/env"

# Install cargo-binstall if not already present.
if ! command -v cargo-binstall >/dev/null 2>&1; then
    echo "Installing cargo-binstall..."
    curl -L --proto '=https' --tlsv1.2 -sSf \
        https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
else
    echo "cargo-binstall already installed, skipping"
fi

# Install tools via binstall. Keyed by package name -> binary name so we can
# skip anything already on PATH. --no-confirm keeps it non-interactive.
declare -A TOOLS=(
    [zoxide]=zoxide
    [eza]=eza
    [starship]=starship
    [ripgrep]=rg
    [tree-sitter-cli]=tree-sitter
)

for pkg in "${!TOOLS[@]}"; do
    bin="${TOOLS[$pkg]}"
    if command -v "$bin" >/dev/null 2>&1; then
        echo "$pkg already installed ($bin), skipping"
    else
        echo "Installing $pkg..."
        cargo binstall --no-confirm "$pkg"
    fi
done
