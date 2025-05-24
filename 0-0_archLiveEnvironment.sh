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

echo "Setting up time and keymaps..."

timedatectl set-npt true
loadkeys us
pacman -Syyy

echo "│-------------------------------------│"
echo "│------- Select disc to format -------│"
echo "│-------------------------------------│"

lsblk

echo "Please entre the disc to format (e.g. /dev/sdx):"
echo -e "\033[91mTHIS WILL DELETE ALL DATA FROM THE DISC\033[0m"
read discName

echo "Formatting disc..."

# Prepare Disc
sgdisk -Z ${discName} # Clear existing GPT and MBR table
sgdisk -a 2048 -o ${discName} # New gpt disk 2048 alignment

# Calculate Swap Space
# Swap = Physical, hibernate
userMem=$((`grep MemTotal /proc/meminfo | awk '{print $2}'`/1024)) # Calculate physical memory in MiB

# Create Partitions
sgdisk -n 1:0:+1000M ${discName} # Partition 1 (UEFI SYS), default start block, 512MB
sgdisk -n 2:0:"+${userMem}M" ${discName} # Partition 2, SWAP, default start block, physical memory
sgdisk -n 3:0:0 ${discName} # Partition 3 (Root), default start, remaining

# Set Partition Types
sgdisk -t 1:ef00 ${discName}
sgdisk -t 2:8200 ${discName}
sgdisk -t 3:8300 ${discName}

# Label Partitions
sgdisk -c 1:"UEFIBOOT" ${discName}
sgdisk -c 2:"SWAP" ${discName}
sgdisk -c 3:"ROOT" ${discName}

# Create Filesystems
echo -e "\n Successfully partitioned disc!"
echo -e "Creating Filesystems...\n$HR"

mkfs.vfat -F32 -n "UEFIBOOT" "${discName}1"
mkswap "${discName}2"
mkfs.ext4 -L "ROOT" "${discName}3"

# Mount Target
mkdir /mnt
mount -t ext4 "${discName}3" /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount -t vfat "${discName}1" /mnt/boot/

swapon "${discName}2"

echo "---------------------------------------"
echo -e "----------- Installing \033[96mArch\033[0m -----------"
echo "---------------------------------------"

# Base Packages
pacstrap /mnt base base-devel --noconfirm --needed

# Kernel
pacstrap /mnt linux linux-firmware --noconfirm --needed

echo "---------------------------------------"
echo "--------- Setup Dependencies ----------"
echo "---------------------------------------"

pacstrap /mnt networkmanager grub efibootmgr --noconfirm --needed

# fstab
genfstab -U /mnt >> /mnt/etc/fstab
echo "\n\033[107m"
cat /mnt/etc/fstab
echo "\n\033[0m"
echo "Please check if the FSTab was properly generated."
read hold

echo "---------------------------------------"
echo "------ Moving Installation Files ------"
echo "---------------------------------------"

installFiles=( "0-0_archLiveEnvironment.sh" "0-1_rootInitialSetup.sh" )

mkdir /mnt/archer/

for i in "${installFiles[@]}"
do
  mv "$i" /mnt/archer/
done

echo "---------------------------------------"
echo "---- Cleaning Up Live Environment -----"
echo "---------------------------------------"

cd ..
rm -rf ./archer/

echo "---------------------------------------"
echo "----- SYSTEM READY FOR FIRST BOOT -----"
echo "---------------------------------------"

echo "You should now add users and then navigate to /archer/ and continue setup."

arch-chroot /mnt
