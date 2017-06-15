#!/bin/bash

# Create new folder in ~/.vim/pack that contains a  folder and cd into it.
#
# Arguments:
#   package_group, a string folder name to create and change into.
#
# Examples:
#   set_group syntax-highlighting
#
function set_group () {
  package_group=$1
  package_type=$2
  path="$HOME/.vim/pack/$package_group/$package_type"
  mkdir -p "$path"
  cd "$path" || exit
}

# Clone or update a git repo in the current directory.
#
# Arguments:
#   repo_url, a URL to the git repo.
#
# Examples:
#   package https://github.com/tpope/vim-endwise.git
#
function package () {
  repo_url="https://github.com/$1.git"
  expected_repo=$(basename "$repo_url" .git)
  if [ -d "$expected_repo" ]; then
    cd "$expected_repo" || exit
    result=$(git pull --force)
    echo "$expected_repo: $result"
  else
    echo "$expected_repo: Installing..."
    git clone -q "$repo_url"
  fi
}

(
set_group navigation start
package ctrlpvim/ctrlp.vim  &
package scrooloose/nerdtree  &
package dyng/ctrlsf.vim  &
package vim-airline/vim-airline  &
package vim-airline/vim-airline-themes  &
wait
) &

(
set_group text-utils start
package tomtom/tcomment_vim  &
package tpope/vim-surround  &
package tpope/vim-repeat  &
package terryma/vim-multiple-cursors  &
package tpope/vim-unimpaired  &
package kshenoy/vim-signature &
package easymotion/vim-easymotion &
wait
) &

(
set_group python start
package python-mode/python-mode  &
package tmhedberg/SimpylFold  &
package heavenshell/vim-pydocstring &
# package vim-scripts/indentpython.vim  &
# package nvie/vim-flake8  &
wait
) &

(
set_group python opt
package Valloric/YouCompleteMe opt &
wait
) &

(
set_group sql opt
package cosminadrianpopescu/vim-sql-workbench &
package vim-scripts/dbext.vim &
wait
) &

(
set_group markdown start
package JamshedVesuna/vim-markdown-preview  &
package godlygeek/tabular  &
package plasticboy/vim-markdown  &
wait
) &

(
set_group VCS start
package tpope/vim-fugitive  &
# package airblade/vim-gitgutter  &
wait
) &

(
set_group syntax start
package scrooloose/syntastic  &
wait
) &

(
set_group colorschemes start
package jnurmine/Zenburn  &
wait
) &

wait
