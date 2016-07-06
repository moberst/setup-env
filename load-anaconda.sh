#!/usr/bin/env bash

cd ~
wget http://repo.continuum.io/archive/Anaconda3-4.1.0-Linux-x86_64.sh
bash Anaconda3-4.1.0-Linux-x86_64.sh
echo 'PATH="/home/ubuntu/anaconda3/bin:$PATH"' >> .bashrc
. .bashrc
