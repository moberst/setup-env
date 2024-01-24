#!/bin/sh

LOCAL_TEX_DIR="/home/moberst/texmf/tex/latex"

rm -rf $LOCAL_TEX_DIR
mkdir -p $LOCAL_TEX_DIR

cp custom-pkg/* $LOCAL_TEX_DIR

# Refresh the tree
sudo texhash
sudo mktexlsr
