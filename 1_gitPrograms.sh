#!/usr/bin/env bash
echo -e "\033[91m╓───────────────────────────────────────────────────────┐"
echo -e "║       _____________________    __  ______________     │"
echo -e "║      ╱  ╲│  __  │ │  _____│\033[31m│\033[91m  │ │ │  ____│  __  │     │"
echo -e "║     ╱ ╱╲ ╲ │\033[31m│\033[91m │ │ │ │\033[31m│\033[91m  │ │\033[31m│\033[91m  │ │ │ │\033[31m│\033[91m   │ │\033[31m│\033[91m │ │     │"
echo -e "║    ╱ ╱__╲ ╲│__│ │ │ │\033[31m│\033[91m  │ │___│ │ │ │___ │ │__│ │     │"
echo -e "║   ╱ ______ ╲___ ╲ │ │\033[31m│\033[91m  │  ___  │ │  __│ │ ____ ╲     │"
echo -e "║  ╱ ╱\033[31m╱\033[91m     ╲ ╲  ╲ ╲│ │___│ │\033[31m│\033[91m  │ │ │ │____│ │\033[31m│\033[91m  ╲ ╲    │"
echo -e "║ ╱_╱\033[31m╱\033[91m       ╲_╲  ╲_╲_____│_│\033[31m│\033[91m  │_│ │______│_│\033[31m│\033[91m   ╲_╲   │"
echo -e "║ Arch Linux Setup and Config Script by Patchouli Fleur │"
echo -e "║ System Installation                                   │"
echo -e "╚═══════════════════════════════════════════════════════╛\033[0m"

echo
echo "DOWNLOADING SOFTWARE OVER GIT AND COMPILING"
echo

echo "Please enter username:"
read username

cd "/home/${username}"

echo
echo "Cloning and installing: DWM"
git clone "https://git.suckless.org/dwm"

cd "/home/${username}/dwm/"
make clean install

echo
echo "Cloning and installing: DMenu"
git clone "https://git.suckless.org/dmenu"

cd "/home/${username}/dmenu/"
make clean install

echo
echo "Cloning and installing: SLStatus"
git clone "https://git.suckless.org/slstatus"

cd "/home/${username}/slstatus/"
make clean install

echo "Cloning and installing: YAY"
git clone "https://aur.archlinux.org/yay.git"

cd "/home/${username}/yay/"
makepkg -si

yay -Y --gendb
yay -Y --devel --save

echo
echo "Done!"
echo
