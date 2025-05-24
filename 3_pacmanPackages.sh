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
echo "Installing Base System"
echo

PKGS=(

    # --- Linux
      'linux-lts'                 # Linux long term support kernel

    # --- XORG Display Rendering
      'xorg'                      # Base Package
      'xorg-drivers'              # Display Drivers 
      'xterm'                     # Terminal for TTY
      'xorg-server'               # XOrg server
      'xscreensaver '             # Screensaver and screen locker for X11
      'xorg-apps'                 # XOrg apps group
      'xorg-xinit'                # XOrg init
      'xorg-xinput'               # XOrg xinput
      'xorg-xgamma'               # XOrg Gamma Control
      'mesa'                      # Open source version of OpenGL
      'lib32-mesa'                # OpenGL for multilib
      #'xf86-video-amdgpu'         # XOrg amdgpu video driver
      #'vulkan-radeon'             # XOrg vulcan driver AMD
      'xf86-video-intel'          # XOrg intel video driver
      'vulkan-intel'              # XOrg vulcan dirver for Intel
      'lib32-vulkan-intel'        # XOrg vulcan multilib
      'wmname'                    # Suckless tool for printing the root window

    # --- Setup Desktop
      'picom'                     # Translucent Windows
      'xclip'                     # System Clipboard
      'gnome-polkit'              # Elevate Applications
      'lxappearance'              # Set System Themes

    # --- Networking Setup
      'dialog'                    # Enables shell scripts to trigger dialog boxex
      'networkmanager'            # Network connection manager
      'openvpn'                   # Open VPN support
      'networkmanager-openvpn'    # Open VPN plugin for NM
      #'network-manager-applet'    # System tray icon/utility for network connectivity
      'dhcpd'                     # DHCP client
      'pass'                      # Unix-philosophy password manager
      'fail2ban'                  # Ban IP's after man failed login attempts
      'ufw'                       # Uncomplicated firewall
      'ntp'                       # Network Time Protocol to sync time
    
    # --- Audio
      'alsa-utils'                # Advanced Linux Sound Architecture (ALSA) Components https://alsa.opensrc.org/
      'alsa-plugins'              # ALSA plugins
      'pipewire'                  # A low level audio/video server https://pipewire.org/
      'pipewire-alsa'             # Pipewire for ALSA programs
      'lib32-pipewire'            # Pipewire multilib support
      'wireplumber'               # Pipewire alsa routing

    # --- Bluetooth
      #'bluez'                     # Daemons for the bluetooth protocol stack
      #'bluez-utils'               # Bluetooth development and debugging utilities
      #'bluez-libs'                # Bluetooth libraries
      #'bluez-firmware'            # Firmware for Broadcom BCM203x and STLC2300 Bluetooth chips
      #'blueberry'                 # Bluetooth configuration tool
      #'pulseaudio-bluetooth'      # Bluetooth support for PulseAudio

    # --- System Health
      'acpid'                     # ACPI Event manager
      'tlp'                       # Laptop power management https://linrunner.de/tlp/
      'czkawka-gui-bin'		  # Disc Space Utility
    
    # --- Terminal Utilities
      'btop'                      # Process and system usage viewer
      'cronie'                    # Cron jobs
      'curl'                      # URL client
      'gufw'                      # Graphical UFW front-end
      'gzip'                      # Unarchive gz files
      'kitty'                     # Terminal Emulator
      'numlockx'                  # Turns on numlock in X11
      'p7zip'                     # 7zip archive manager
      'pdftk'                     # PDF management system
      'rsync'                     # Remote file syncing
      'unrar'                     # Unarchive rar files
      'unzip'                     # Unarchive zip files
      'vifm'                      # Vim-like file manager
      'wget'                      # Remote downloader
      'zsh'                       # Nice shell
      'zsh-autosuggestions'       # Zsh Plugin
      'zsh-syntax-highlighting'   # Zsh Plugin

    # --- Development
      'clang'                     # C compiler and requirement for nvim completion
      'cmake'                     # Make system
      'git'                       # Git VCS
      'meld'                      # File and directory comparison

    # --- Multimedia
      'feh'
      'mpv'
      'ncmpcpp'

    # --- Language and font
      'hunspell'
      'hunspell-en'
      'hunspell-pl'
      'fcitx5-im'
      'fcitx5-chinese-addons'
      'fcitx5-pinyin-zhwiki'
      'terminus-font'
      'ttf-cascadia-code-nerd'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

# Need to get it to clone DWM and DMenu

echo
echo "Done!"
echo
