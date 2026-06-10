curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -y
source $HOME/.cargo/env

curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

cargo binstall zoxide
cargo binstall eza
cargo binstall starship
cargo binstall ripgrep
cargo binstall tree-sitter-cli
