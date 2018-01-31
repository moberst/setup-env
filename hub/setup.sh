#!/bin/bash
HUB_VERSION="v2.3.0-pre10"
HUB_PKG="hub-linux-amd64-2.3.0-pre10"

wget "https://github.com/github/hub/releases/download/$HUB_VERSION/$HUB_PKG.tgz"
tar -xvf "$HUB_PKG.tgz"
rm "$HUB_PKG.tgz"

mv "$HUB_PKG" "$HOME/.hub"
cd "$HOME/.hub"
sudo ./install

