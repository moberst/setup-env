#!/bin/bash

# Install development tools and cmake
sudo apt-get install build-essential cmake

# Make sure you have python headers installed
sudo apt-get install python-dev python3-dev

# Compiling YCM without semantic support for C-family languages:
cd ~/.vim/bundle/YouCompleteMe
./install.py

