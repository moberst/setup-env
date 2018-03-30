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
		FULL_SETUP=1
		;;
	p)
		PRESENTATION=1
		;;
	d)
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
  cp $SCRIPT_HOME/introduction.tex \
     $SCRIPT_HOME/natbib.sty $SCRIPT_HOME/jmb.bst $SCRIPT_HOME/main.tex \
     $SCRIPT_HOME/base.bib $NAME

  # No Makefile, just use vimtex

  # Change file names
  mv $NAME/introduction.tex $NAME/sections/

  echo "Initializing Git Repository"
  # Initialize git repository
  cd $NAME
  git init 

elif [ $PRESENTATION -eq 1 ]; then
  echo "Moving presentation files"
  mkdir $NAME/tex
  cp $SCRIPT_HOME/header.tex $NAME/tex/header.tex
  cp $SCRIPT_HOME/basic_presentation.tex $NAME/presentation.tex

else
  echo "Moving basic files"
  mkdir $NAME/tex
  cp $SCRIPT_HOME/basic.tex $NAME/notes.tex
fi
