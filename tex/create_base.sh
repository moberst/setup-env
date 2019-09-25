#!/bin/bash

OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Enable this to be run from another directory (where the project lives)
SCRIPT_HOME="$HOME/repos/setup-env/tex"
NAME=""
FULL_SETUP=0
PRESENTATION=0

# Parse arguments
while getopts "h?fpd:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    f)
        NAME=$OPTARG
        FULL_SETUP=1
        ;;
    p)
        NAME=$OPTARG
        PRESENTATION=1
        ;;
    n)
        NAME=$OPTARG
        ;;
    esac
done

# Check if directory already exists
if [ -d "$NAME" ]; then
    echo "Error: Directory $NAME exists!"
    exit 1
fi

echo "Creating directory structure for $NAME"
# Create directory structure
mkdir $NAME

if [ $FULL_SETUP -eq 1 ]; then
    mkdir $NAME/figs
    mkdir $NAME/sections

    echo "Moving files"
    # Move over the files
    cp $SCRIPT_HOME/example_paper.tex $SCRIPT_HOME/icml2019.bst \ 
       $SCRIPT_HOME/example_references.bib $NAME

    # No Makefile, just use vimtex

    # Initialize abstract / intro
    mv $NAME/example_paper.tex $NAME/main.tex
    mv $NAME/example_references.tex $NAME/references.tex
    touch $NAME/sections/0-abstract
    touch $NAME/sections/1-introduction

elif [ $PRESENTATION -eq 1 ]; then
    echo "Moving presentation files"
    cp $SCRIPT_HOME/example_presentation.tex $NAME/main.tex
    cp $SCRIPT_HOME/example_references.tex $NAME/references.tex

else
    echo "Moving basic files"
    cp $SCRIPT_HOME/example_notes.tex $NAME/notes.tex
    cp $SCRIPT_HOME/example_references.bib $NAME/references.bib
    cp $SCRIPT_HOME/icml2019.tex $NAME
fi
