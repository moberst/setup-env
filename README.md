# Workflow for setting up a new machine

## Setup Git
* Download `gh` and setup to clone this repo
* Install lazygit
* Update git configuration with `git/configure.sh`

## Setup command line essentials
* Download `neovim` and set up in `~/.neovim/bin`
* Download `fzf` and set it up in `~/.local/bin`
* Download rust via 
```
curl https://sh.rustup.rs -sSf | sh
```
* Setup essential command line tools
```
cargo install zoxide
cargo install eza
cargo install starship --locked
```
* Now you can configure bash via `bash/configure.sh` without throwing errors

## Setup Neovim

Note: For remote machines, use the `remote-other` branch which has fewer unnecessary nvim packages.
* Run `nvim/configure.sh`

