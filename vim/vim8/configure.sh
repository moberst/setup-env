#!/bin/bash

VIM_DIR="$HOME/.vim"

# setup .vimrc
cp vimrc ~/.vimrc

# Update plugins
sudo cp install_pack.sh $VIM_DIR/pack/install_pack.sh
cd $VIM_DIR/pack
sudo bash install_pack.sh

sudo vim -c "helptags ALL"
