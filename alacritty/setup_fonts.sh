#/bin/bash
FONT=FiraMono

cd ~
echo "[-] Download fonts [-]"
echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/${FONT}.zip"

wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/${FONT}.zip"
mkdir -p .local/share/fonts
unzip "${FONT}.zip" -d ~/.local/share/fonts

cd ~/.local/share/fonts
rm *Windows*

cd ~
rm "${FONT}".zip
fc-cache -fv
echo "done!"
