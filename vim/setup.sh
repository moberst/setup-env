#!/bin/bash
PYTHON_CONFIG_DIR="/usr/lib/python2.7/config-x86_64-linux-gnu"
PYTHON_3_CONFIG_DIR="/usr/lib/python3.6/config-3.5m-x86_64-linux-gnu"

SETUP_DIR="$HOME/repos/setup-env/vim/"
VIM_DIR="$HOME/.vim"

# Delete vim if it already exists
rm -rf "$VIM_DIR"

# Clone the source code into the directory
if [ ! -d "$VIM_DIR" ] ; then
    git clone https://github.com/vim/vim.git "$VIM_DIR"
    cd "$VIM_DIR/src"
    git pull && git fetch
    make distclean
    ./configure --with-features=huge \
            --enable-multibyte \
            --enable-pythoninterp=dynamic \
            --with-python-config-dir="$PYTHON_CONFIG_DIR"\
            --enable-python3interp \
            --with-python3-config-dir="$PYTHON_3_CONFIG_DIR"\
            --with-x \
            --with-compiledby="moberst" \
            --enable-fail-if-missing \
            --enable-fontset \
            --enable-largefile \
            --disable-netbeans \
            --enable-gui=auto \
            --enable-cscope
    make
    make install
fi

mkdir "$VIM_DIR/pack"
cp $SETUP_DIR/install_pack.sh $VIM_DIR/pack/install_pack.sh
cd $VIM_DIR/pack
bash install_pack.sh

vim -c "helptags ALL"
