#!/bin/bash

# Initialize our own variables
DEST_DIR=$HOME
DOWNLOAD_URL_BASE="https://repo.continuum.io"
DOWNLOAD_URL_DIR="miniconda"
DOWNLOAD_FILE="Miniconda3-latest-Linux-x86_64.sh"

# Place the downloaded file in our destination directory
wget -P "$DEST_DIR" "$DOWNLOAD_URL_BASE/$DOWNLOAD_URL_DIR/$DOWNLOAD_FILE"

# Run the installation and delete the file
bash "$DEST_DIR/$DOWNLOAD_FILE"
rm "$DEST_DIR/$DOWNLOAD_FILE"

