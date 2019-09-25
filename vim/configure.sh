#!/bin/bash

VIM_DIR="$HOME/.vim"

# setup .vimrc
cp vimrc ~/.vimrc

# Update plugins
if [[ ! -d $VIM_DIR/pack ]]; then
  mkdir $VIM_DIR/pack
fi
cp install_pack.sh $VIM_DIR/pack/install_pack.sh
cd $VIM_DIR/pack
bash install_pack.sh

vim -c "helptags ALL"
