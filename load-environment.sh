#!/usr/bin/env bash

# Load our anaconda distribution
cd ~
wget http://repo.continuum.io/archive/Anaconda2-4.0.0-Linux-x86_64.sh
bash Anaconda2-4.0.0-Linux-x86_64.sh -b
echo 'PATH="/home/ubuntu/anaconda2/bin:$PATH"' >> .bashrc
. .bashrc

# Install git
# sudo apt-get install git-all

# Use unzip to get files from Kaggle or other sites that are zipped
sudo apt-get install unzip
