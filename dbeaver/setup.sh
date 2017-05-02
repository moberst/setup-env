wget -P $HOME "https://github.com/serge-rider/dbeaver/releases/download/4.0.5/dbeaver-ce_4.0.5_amd64.deb"

sudo dpkg -i "$HOME/dbeaver-ce_4.0.5_amd64.deb"

sudo apt-get install -f
