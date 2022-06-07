#!/bin/sh

# Make pylintrc the fallback option
# sudo cp config/pylint_config /etc/pylintrc

# Defaults for other linters
cp config/yapf_config ~/.config/yapf/style
cp config/mypy_config ~/.config/mypy/config
cp config/flake_config ~/.config/flake8
