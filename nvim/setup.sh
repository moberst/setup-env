# Install pre-reqs
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

cd $HOME/repos/setup-env/nvim/neovim
rm -r build/
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.neovim"
make install
export PATH="$HOME/.neovim/bin:$PATH"
