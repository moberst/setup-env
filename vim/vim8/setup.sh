#!/bin/bash

VIM_DIR="$HOME/.vim"

# Delete vim if it already exists
sudo rm -rf "$VIM_DIR"
sudo apt remove vim

# Clone the source code into the directory
if [ ! -d "$VIM_DIR" ] ; then
	git clone https://github.com/vim/vim.git "$VIM_DIR"
	cd "$VIM_DIR/src"
	make distclean
	make
	sudo make install
fi

sudo mkdir "$VIM_DIR/pack"
sudo cp install_pack.sh $VIM_DIR/pack/install_pack.sh
cd $VIM_DIR/pack
sudo bash install_pack.sh
