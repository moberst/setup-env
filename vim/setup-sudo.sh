#!/bin/bash
apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common

apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python3-dev python-dev

apt-get install checkinstall

PYTHON_CONFIG_DIR="/usr/lib/python2.7/config-x86_64-linux-gnu"
PYTHON_3_CONFIG_DIR="/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu"

SETUP_DIR="$HOME/repos/setup-env/vim/"
VIM_DIR="$HOME/.vim"

# Delete vim if it already exists
rm -rf "$VIM_DIR"
rm -rf /usr/local/share/vim /usr/bin/vim
apt remove vim

# Clone the source code into the directory
if [ ! -d "$VIM_DIR" ] ; then
    git clone https://github.com/vim/vim.git "$VIM_DIR"
    cd "$VIM_DIR/src"
    git pull && git fetch
    make distclean
    ./configure --with-features=huge \
            --enable-multibyte \
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
