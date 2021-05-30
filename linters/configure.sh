#!/bin/sh

# Note: These are used for ALE, linting in nvim.coc should be disabled

# Make pylintrc the fallback option
sudo cp config/pylint_config /etc/pylintrc

# Defaults for yapf
cp config/yapf_config ~/.config/yapf/style
cp config/mypy_config ~/.config/mypy/config
cp config/flake_config ~/.config/flake8
