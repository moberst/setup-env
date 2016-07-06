#!/usr/bin/env bash

# Create a new environment
conda create -n tensorflow python=3.5
source activate tensorflow

# Set address for (non-GPU) version of tensorflow
TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0-cp35-cp35m-linux_x86_64.whl

# Install using pip 
pip3 install --upgrade $TF_BINARY_URL
