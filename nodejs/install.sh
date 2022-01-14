#!/bin/sh

# Check https://github.com/nvm-sh/nvm for latest version
VERSION='v0.39.1'
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${VERSION}/install.sh" | bash

# Source the new configuration 
source ~/.bashrc

# Install the latest version
nvm install node
