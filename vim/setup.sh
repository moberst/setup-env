#!/bin/bash

sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python3-dev 

PYTHON_CONFIG_DIR="/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu"

SETUP_DIR="$HOME/repos/setup-env/vim/"
VIM_DIR="$HOME/.vim"

# Delete vim if it already exists
sudo rm -rf "$VIM_DIR"
sudo apt remove vim

# Clone the source code into the directory
if [ ! -d "$VIM_DIR" ] ; then
	git clone https://github.com/vim/vim.git "$VIM_DIR"
	cd "$VIM_DIR/src"
	make distclean
  ./configure --with-features=huge \
            --enable-multibyte \
            --enable-python3interp=yes \
            --with-python3-config-dir=$PYTHON_CONFIG_DIR \
            --enable-cscope 
	make
	sudo make install
fi

sudo mkdir "$VIM_DIR/pack"
sudo cp $SETUP_DIR/install_pack.sh $VIM_DIR/pack/install_pack.sh
cd $VIM_DIR/pack
sudo bash install_pack.sh

sudo vim -c "helptags ALL"
