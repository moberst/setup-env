#!/bin/bash

# Install vim
sudo apt-get update
sudo apt-get install vim
sudo apt-get install ack-grep

# Set up plugins and .vimrc
VUNDLE_PATH="$HOME/.vim/bundle/Vundle.vim"

# Download vundle package manager
if [ -d "$VUNDLE_PATH" ] ;
then
	echo "Vundle is already installed, skipping..."
else
	git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_PATH"
fi

