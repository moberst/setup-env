#!/bin/bash

echo "Installing rust and other utilities"
bash install_scripts/install.sh

echo "Configuring bash, git, starship, nvim"
bash bash/configure.sh
bash git/configure.sh
bash starship/configure.sh
bash nvim/configure.sh
