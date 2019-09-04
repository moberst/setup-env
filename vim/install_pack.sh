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
    git clone -q --recurse-submodules "$repo_url"
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
package vim-scripts/taglist.vim &
wait
) &

(
set_group text-utils opt
package gyim/vim-boxdraw &
wait
) &

(
set_group python start
package python-mode/python-mode  &
package tmhedberg/SimpylFold  &
package heavenshell/vim-pydocstring &
wait
) &

(
set_group snips start
package SirVer/ultisnips &
package moberst/vim-snippets &
package ervandew/supertab &
wait
) &

(
set_group snips opt
package Valloric/YouCompleteMe &
wait
) &

(
set_group python opt
package vim-scripts/indentpython.vim  &
package ambv/black &
wait
) &

(
set_group sql opt
package lifepillar/pgsql.vim &
package cosminadrianpopescu/vim-sql-workbench &
package vim-scripts/dbext.vim &
wait
) &

(
set_group ember opt
package joukevandermaas/vim-ember-hbs &
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
set_group rmarkdown opt
package vim-pandoc/vim-pandoc &
package vim-pandoc/vim-pandoc-syntax  &
package vim-pandoc/vim-rmarkdown  &
wait
) &

(
set_group latex start
package xuhdev/vim-latex-live-preview &
package lervag/vimtex &
wait
) &

(
set_group VCS start
package tpope/vim-fugitive  &
package airblade/vim-gitgutter  &
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

(
set_group colorschemes opt
package tomasr/molokai &
wait
) &

wait
