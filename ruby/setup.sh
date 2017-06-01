#!/bin/bash

# Clone the repo
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

# Optional: Try to install bash extension to speed it up
cd ~/.rbenv && src/configure && make -C src

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Install ruby-build
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Use ruby-build to install ruby itself
rbenv install 2.4.1

# Install ruby-gems
git clone https://github.com/rubygems/rubygems ~/.rubygems 
cd ~/.rubygems
git submodule update -\-init
ruby setup.rb

