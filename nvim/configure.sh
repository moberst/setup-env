#!/bin/sh

rm -rf ~/.config/nvim
mkdir ~/.config/nvim
mkdir ~/.config/nvim/lua
cp ~/repos/setup-env/nvim/init.lua ~/.config/nvim/init.lua
cp -R ~/repos/setup-env/nvim/snippets ~/.config/nvim
cp -R ~/repos/setup-env/nvim/config ~/.config/nvim/lua
cp -R ~/repos/setup-env/nvim/plugins ~/.config/nvim/lua
