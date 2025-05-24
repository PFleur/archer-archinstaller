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
echo "INSTALLING AUR SOFTWARE"
echo

echo "Please enter username:"
read username

cd "/home/${username}/"

PKGS=(

    # UTILITIES -----------------------------------------------------------

    'timeshift'                 # Backup and Restore

    # COMMUNICATIONS ------------------------------------------------------

    'librewolf-bin'                 # Librewolf fork of firefox

    # THEMES --------------------------------------------------------------

    #'materia-gtk-theme'             # Desktop Theme
    #'papirus-icon-theme'            # Desktop Icons

)

cd "/home/${username}/yay/"
makepkg -si

# Change default shell
chsh -s $(which zsh)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

echo
echo "Done!"
echo
