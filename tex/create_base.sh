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
cp $SCRIPT_HOME/custom-pkg/shortcuts.sty $NAME/shortcuts.sty
cp $SCRIPT_HOME/example_notes.tex $NAME/notes.tex
cp $SCRIPT_HOME/example_references.bib $NAME/references.bib
cp $SCRIPT_HOME/paperSpecificShortcuts.tex $NAME
cp $SCRIPT_HOME/packages.tex $NAME
cp $SCRIPT_HOME/formatting.tex $NAME
cp $SCRIPT_HOME/icml2022.bst $NAME
