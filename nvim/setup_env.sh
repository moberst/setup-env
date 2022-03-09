#!/bin/sh

# This is a hack to get conda shell commands within the script, see
# https://github.com/conda/conda/issues/7126
source $(dirname $CONDA_EXE)/../etc/profile.d/conda.sh

ENV='nvim'
conda create --name ${ENV} python=3.8

# Conda installations go here
# conda install -n ${ENV} pandas
# conda install -n ${ENV} jupyter
# conda install -n ${ENV} numpy
# conda install -n ${ENV} scipy
# conda install -n ${ENV} matplotlib
# conda install -n ${ENV} seaborn
# conda install -n ${ENV} tqdm

# Pip installation goes here
conda activate ${ENV}

# These are basic integrations
pip install --upgrade pip
pip install --upgrade pynvim

# Library required for ueberzug
sudo apt-get install libxext-dev
# These are for Magma, running Jupyter in Vim
pip install --upgrade jupyter-client
pip install --upgrade ueberzug
pip install --upgrade Pillow
pip install --upgrade cairosvg
pip install --upgrade pnglatex
pip install --upgrade plotly
pip install --upgrade kaleido

# These are linters 
pip install --upgrade flake8
pip install --upgrade pydocstyle
pip install --upgrade mypy
pip install --upgrade yapf
pip install --upgrade pylint
