#!/bin/bash

# Clone the repo
if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	# Optional: Try to install bash extension to speed it up
	cd ~/.rbenv && src/configure && make -C src
fi

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Install ruby-build
if [ ! -d ~/.rbenv/plugins/ruby-build ]; then
	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# Use ruby-build to install ruby itself
sudo apt-get install -y libssl-dev libreadline-dev
~/.rbenv/bin/rbenv install 2.4.1

# Install ruby-gems
if [ ! -d ~/.rubygems ]; then
	git clone https://github.com/rubygems/rubygems ~/.rubygems 
fi

cd ~/.rubygems
git submodule update -\-init
ruby setup.rb

