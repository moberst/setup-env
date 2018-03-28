#!/bin/bash

# Modified script from 
# https://ryanbigg.com/2014/10/ubuntu-ruby-ruby-install-chruby-and-you
wget -O ruby-install-0.6.1.tar.gz \
  https://github.com/postmodern/ruby-install/archive/v0.6.1.tar.gz
tar -xzvf ruby-install-0.6.1.tar.gz 
cd ruby-install-0.6.1/
sudo make install
