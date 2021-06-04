# Install pre-reqs
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

# Create the repository if it does not exist
cd $HOME/repos/setup-env/nvim
git submodule add https://github.com/neovim/neovim.git neovim-nightly
git submodule update --init --recursive

# Use the latest version, i.e., do not checkout a release
cd $HOME/repos/setup-env/nvim/neovim-nightly
git co nightly
