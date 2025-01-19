#!/bin/sh

# Get Fresh config
git show lazy:nvim/kickstart.lua > tmp.lua

rm ~/.config/nvim -rf
mkdir ~/.config/nvim
cp ~/repos/setup-env/nvim/tmp.lua ~/.config/nvim/init.lua
rm tmp.lua
