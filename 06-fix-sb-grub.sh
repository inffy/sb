#/bin/bash
set -eux

echo "Fix Silverblue GRUB"

sudo touch /boot/grub2/.grub2-blscfg-supported

echo "Creating new Grub config"
sudo grub2-mkconfig -o /etc/grub2-efi.cfg

echo "Done, please reboot and check :)"
