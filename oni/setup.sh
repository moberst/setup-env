VERSION=0.3.9
FILENAME=Oni-${VERSION}-amd64-linux.deb

# Get and install the deb file, then wipe
wget https://github.com/onivim/oni/releases/download/v${VERSION}/${FILENAME}
sudo dpkg -i ${FILENAME}
rm ${FILENAME} 

# Run configuration
bash configure.sh
