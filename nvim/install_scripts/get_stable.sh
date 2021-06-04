# Install pre-reqs
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

# Create the repository if it does not exist
cd $HOME/repos/setup-env/nvim
git submodule add https://github.com/neovim/neovim.git neovim
git submodule update --init --recursive

# Checkout the release version
cd $HOME/repos/setup-env/nvim/neovim
git checkout stable
