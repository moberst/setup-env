#!/usr/bin/env bash

jupyter notebook --generate-config

cd ~
sed -i "1 a\
c = get_config()\\
c.NotebookApp.ip = '*'\\
c.NotebookApp.open_browser = False\\
c.NotebookApp.port = 8082" .jupyter/jupyter_notebook_config.py
