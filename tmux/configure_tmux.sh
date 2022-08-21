#!/bin/sh

if [ ! -d ~/.tmux/plugins/tpm ]; then
  mkdir -p ~/.tmux/plugins/tpm
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# cat tmux_tokyonight.conf tmux.conf > $HOME/.tmux.conf
cat ./themes/tmux_catppuccin.conf tmux.conf > $HOME/.tmux.conf
cp ./layouts/driver.yml $HOME/.config/tmuxinator/driver.yml
cp ./layouts/driver-small.yml $HOME/.config/tmuxinator/driver-small.yml
