#!/bin/sh

rm ~/.config/nvim -rf
mkdir ~/.config/nvim
cp ~/repos/setup-env/nvim/kickstart.lua ~/.config/nvim/init.lua
cp ~/repos/setup-env/nvim/snippets ~/.config/nvim -r

