# Download latest release
wget https://github.com/neovim/neovim/releases/download/v0.12.0/nvim-linux-x86_64.tar.gz

# Unzip and clean up
tar xzvf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz

# Replace neovim directory with latest
rm ~/.neovim -r
mv nvim-linux-x86_64 ~/.neovim 


