#!/bin/sh

wget https://github.com/Wilfred/difftastic/releases/download/0.69.0/difft-x86_64-unknown-linux-gnu.tar.gz
tar xzf difft-x86_64-unknown-linux-gnu.tar.gz
rm difft-x86_64-unknown-linux-gnu.tar.gz
mv difft $HOME/.local/bin

