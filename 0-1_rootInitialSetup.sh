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

echo "---------------------------------------"
echo "--- Bootloader Systemd Installation ---"
echo "---------------------------------------"

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

echo "Starting Network Manager"
systemctl enable NetworkManager

echo "---------------------------------------"
echo "-- Optimising Pacman And Make Cores ---"
echo "---------------------------------------"

echo "What courtry do you want to optimise the mirrorlist for (input as ISO 3166-1 alpha-2 two letter code I think):"
echo "Currently only works for a single country"
read cc #Country code

pacman -Syyy
pacman -S --noconfirm pacman-contrib curl less nvim
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl -s "https://archlinux.org/mirrorlist/?country=${cc}&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

#sed -i 's/#\[multilib\]/\[multilib\]/g' /etc/pacman.conf
#sed -i '/\[multilib\]$/{n;s/^#Include = \/etc\/pacman.d\/mirrorlist/Include/Include = \/etc\/pacman.d\/mirrorlist/;}' /etc/pacman.conf

echo "Pacman mirrorlist optimised for the five fastest https-supporting mirrors"

nc=$(grep -c ^processor /proc/cpuinfo)
echo "You have " $nc" cores."
echo "-------------------------------------------------"
echo "Changing the makeflags for "$nc" cores."
sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j16"/g' /etc/makepkg.conf
echo "Changing the compression settings for "$nc" cores."
sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 16 -z -)/g' /etc/makepkg.conf

echo "---------------------------------------"
echo "------------ Locale Setup -------------"
echo "---------------------------------------"

# Set locales
enGB=en_GB.UTF-8
enDK=en_DK.UTF-8
enUS=en_US.UTF-8

touch /etc/locale.conf
echo "LANG=${enGB}" >> /etc/locale.conf
echo "LC_ADDRESS=${enDK}" >> /etc/locale.conf
echo "LC_IDENTIFICATION=${enUS}" >> /etc/locale.conf
echo "LC_MEASUREMENT=metric" >> /etc/locale.conf
echo "LC_MONETARY=${enUS}" >> /etc/locale.conf
echo "LC_NAME=${enUS}" >> /etc/locale.conf
echo "LC_NUMERIC=${enDK}" >> /etc/locale.conf
echo "LC_PAPER=${enDK}" >> /etc/locale.conf
echo "LC_TELEPHONE=${enUS}" >> /etc/locale.conf
echo "LC_TIME=${enDK}" >> /etc/locale.conf

sed -i "/$enGB/s/^#//g" /etc/locale.gen
sed -i "/$enDK/s/^#//g" /etc/locale.gen
sed -i "/$enUS/s/^#//g" /etc/locale.gen
locale-gen

# Would be nice to have user input but IDK how
#echo "Please check and write down what locales you plan to use."
#read hold
#less /etc/locale.gen

#while localectl set-locale LANG=$userLANG &> /dev/null ; [[ $? -ne 0 ]] ; do
#  echo "What should be the primary locale:"
#  read userLANG
#  sed -i "/$userLANG/s/^#//g" /etc/locale.gen
#  locale-gen
#done
#
#while localectl set-locale LC_TIME=$userLC_TIME &> /dev/null ; [[ $? -ne 0 ]] ; do
#  echo "What should be the primary locale:"
#  read userLC_TIME
#  sed -i "/$userLC_TIME/s/^#//g" /etc/locale.gen
#  locale-gen
#done
#
#while localectl set-locale LC_MONETARY=$userLC_TIME &> /dev/null ; [[ $? -ne 0 ]] ; do
#  echo "What should be the primary locale:"
#  read userLC_MONETARY
#  sed -i "/$userLC_MONETARY/s/^#//g" /etc/locale.gen
#  locale-gen
#done

echo "What timezone should be used:"
read userTime

timedatectl --no-ask-password set-timezone ${userTime}
timedatectl --no-ask-password set-ntp 1

echo "What keymap should be used:"
read userKeymap

localectl --no-ask-password set-keymap ${userKeymap}

echo "Locales are all setup!"

echo "What should the hostname be:"
read userHostname

hostnamectl --no-ask-password set-hostname $userHostname

sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

echo "\033[91m[Please enable the multilib repo in /etc/pacman.conf\033[0m"
echo "Please comment/uncomment needed or unneeded packages in 1_basePackages.sh"
echo "If using Nvidia graphics install those and comment out the AMD and Intel drivers"
