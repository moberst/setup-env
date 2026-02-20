#!/bin/sh

rm ~/.config/nvim -rf
mkdir ~/.config/nvim
mkdir ~/.config/nvim/lua
cp ~/repos/setup-env/nvim/kickstart.lua ~/.config/nvim/init.lua
cp ~/repos/setup-env/nvim/snippets ~/.config/nvim -r
cp ~/repos/setup-env/nvim/config ~/.config/nvim/lua -r
cp ~/repos/setup-env/nvim/plugins ~/.config/nvim/lua -r

