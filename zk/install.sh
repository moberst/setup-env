VERSION='v0.12.0'
FILE="zk-${VERSION}-linux-amd64.tar.gz"
wget "https://github.com/mickael-menu/zk/releases/download/${VERSION}/${FILE}"
tar -xvf $FILE
chmod 755 zk
mv zk /home/moberst/.local/bin
rm $FILE
