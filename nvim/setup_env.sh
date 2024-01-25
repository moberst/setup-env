#!/bin/sh

# This is a hack to get conda shell commands within the script, see
# https://github.com/conda/conda/issues/7126
source $(dirname $CONDA_EXE)/../etc/profile.d/conda.sh

ENV='nvim'
conda create --name ${ENV} python=3.11

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
