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

echo "Moving presentation files"
sed 1,1d $SCRIPT_HOME/shortcuts.sty > $NAME/shortcuts.tex
cp $SCRIPT_HOME/example_presentation.tex $NAME/main.tex
cp $SCRIPT_HOME/example_references.bib $NAME/references.bib
cp $SCRIPT_HOME/icml2019.bst $NAME
cp $SCRIPT_HOME/MIT-Logo-Small.png $NAME
