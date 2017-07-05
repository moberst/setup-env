#!/bin/bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables
DEST_DIR=$HOME
PKG="anaconda" # default to anaconda
DOWNLOAD_URL_BASE="https://repo.continuum.io"
DOWNLOAD_URL_DIR=""
DOWNLOAD_FILE=""

# Parse arguments
while getopts "h?m" opt; do
	case "$opt" in
	h|\?)
		show_help
		exit 0
		;;
	m)
		PKG="miniconda"
		;;
	esac
done

# Determine package to install
echo "Installing $PKG (64-bit, Python3)"

if [ "$PKG" = 'miniconda' ]
then
	DOWNLOAD_URL_DIR="miniconda"
	DOWNLOAD_FILE="Miniconda3-latest-Linux-x86_64.sh"
	
elif [ "$PKG" = 'anaconda' ]
then
	DOWNLOAD_URL_DIR="archive"
	DOWNLOAD_FILE="Anaconda3-4.1.0-Linux-x86_64.sh"

else
	echo "Package ($PKG) not recongnized"
	exit 1
fi

# Place the downloaded file in our destination directory
wget -P "$DEST_DIR" "$DOWNLOAD_URL_BASE/$DOWNLOAD_URL_DIR/$DOWNLOAD_FILE"

# Run the installation and delete the file
bash "$DEST_DIR/$DOWNLOAD_FILE"
rm "$DEST_DIR/$DOWNLOAD_FILE"

