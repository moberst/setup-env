#!/bin/sh

# This is a template script, to make installation of an env reproducible

# This is a hack to get conda shell commands within the script, see
# https://github.com/conda/conda/issues/7126
source $(dirname $CONDA_EXE)/../etc/profile.d/conda.sh

ENV=$1
conda create --name ${ENV} python=3.9.5

# Conda installations go here
conda install -n ${ENV} numpy 

# Pip installation goes here
conda activate ${ENV}

pip install --upgrade pip
pip install --upgrade jax jaxlib # CPU-only version 
