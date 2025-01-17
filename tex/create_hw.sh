#!/bin/bash

OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Enable this to be run from another directory (where the project lives)
SCRIPT_HOME="$HOME/repos/setup-env/tex"
NAME=$1

# Check if directory already exists
if [ -d "$NAME" ]; then
    echo "Error: Directory $NAME exists!"
    exit 1
fi

echo "Creating directory structure for $NAME"
# Create directory structure
mkdir $NAME

echo "Moving basic files"
cp $SCRIPT_HOME/example_homework.tex $NAME/main.tex
cp $SCRIPT_HOME/homework_preamble.tex $NAME/preamble.tex
