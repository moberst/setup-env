#!/bin/sh

# Delete any existing builds, and add new build to path
cd $HOME/repos/setup-env/nvim/neovim
git checkout stable

rm -rf build
make distclean 
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.neovim"
make install
export PATH="$HOME/.neovim/bin:$PATH"
