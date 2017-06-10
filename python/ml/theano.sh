#!/bin/bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables
SYS_PKG=false
CONFIG_FILE="theano.yml"

# Parse arguments
while getopts "h?s" opt; do
	case "$opt" in
	h|\?)
		show_help
		exit 0
		;;
	s)
		SYS_PKG=true
		;;
	esac
done

if [ "$SYS_PKG" = true ];
then
	echo "Installing system updates required"
	echo "(Currently g++, but could include CUDA in the future)"

	# Get the latest version of g++
	sudo apt-get update
	sudo apt-get install g++
else
	echo "Not installing any system updates"
fi

echo "Setting up Conda environment using $CONFIG_FILE"

# Setup conda environment
conda env create -f "$CONFIG_FILE"


