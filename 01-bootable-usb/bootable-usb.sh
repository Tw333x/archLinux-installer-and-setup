#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Bootable USB
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Create a bootable USB
# ----------------------------------------------------------------------


archlinuxImageURL="http://mirror.rackspace.com/archlinux/iso/latest/"

funcContinue() {
	if ! [[ $1 =~ ^([yY][eE][sS]|[yY])+$ ]]; then
		echo -e "\nThe script has been FINISHED."
		exit -1
	fi
}



echo -e ""
echo -e "Create a bootable USB"
echo -e ""

echo -e ""
sudo fdisk -l
echo -e "This is the list with all devices (disks and USB) connected in your computer"

echo -e "\n"
echo -e "Warning: This script delete all partitions and data from the selected device.\n"

read -r -p "Write in lowercase the name for the USB device, e.g. sdb, sdc sdx: " usbDevice

echo -e ""
read -r -p "Is this (/dev/$usbDevice) the USB device? [y/N]: " isThisTheUsb
funcContinue $isThisTheUsb

echo -e ""
echo -e "Umounting the $usbDevice device"
sudo umount -R /dev/$usbDevice &>/dev/null

echo -e ""
echo -e "Deleting all the partitions in you USB ($usbDevice)"
sudo dd if=/dev/zero of=/dev/$usbDevice bs=512 count=1 conv=notrunc &>/dev/null

echo -e ""
echo -e "Creating all partitions and formatting properly"
(
	echo o # Create a new empty DOS partition table
	echo n # Add a new partition
	echo p # Primary partition
	echo 1 # Partition number
	echo   # First sector (Accept default: 1)
	echo   # Last sector (Accept default: varies)
	echo a # toggle a bootable flag
	echo w # Write changes
) | sudo fdisk /dev/$usbDevice &>/dev/null

usbPartition="$usbDevice"1

echo -e ""
echo -e "Creating directory ~/workspace in case this not exists"
mkdir -p ~/workspace


echo -e ""
echo -e "Downloading Arch Linux ISO (image)"
archlinuxISO=$(curl $archlinuxImageURL 2>/dev/null | grep -om 1 "archlinux-....\...\...-x86_64.iso" | head -n1)
echo -e ""
curl -H 'Cache-Control: no-cache' $archlinuxImageURL/$archlinuxISO > ~/workspace/$archlinuxISO

echo -e ""
echo -e "Loading Arch Linux in the USB..."
sudo dd bs=4M if=~/workspace/$archlinuxISO of=/dev/$usbDevice status=progress &>/dev/null && sync &>/dev/null

echo -e ""
echo -e "Display your formatted USB"
sudo fdisk /dev/$usbDevice -l

echo -e "\n"
echo -e "Ready the next step is restart your computer and init the system with your USB.\n"
echo -e "Successful! The bootable USB has been created.\n"