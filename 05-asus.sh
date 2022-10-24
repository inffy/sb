#!/bin/bash
# Get the needes asus repos for S3 patch and stuff
set -eu

# Start the supergfx daemon
sudo systemctl enable --now supergfxd

# Change directory to ~/Projects
cd ~/Projects

# clone the asus misc stuff repo
git clone https://github.com/inffy/g14-2022

cd g14-2022

echo "Installing scripts.."
sudo ./install

# Move the asusd profile.conf to right place
echo "Moving asusd fan curve profile to the correct place"
sudo cp etc/asusd/profile.conf /etc/asusd/

echo "Restart asusd"
sudo systemctl restart asusd

echo "Enable the new Balanced profiles fan curves"
asusctl fan-curve -m balanced -e true

echo "Enable the new quiet profile fan curves"
asusctl fan-curve -m quiet -e true

echo "And finally the performance profile"
asusctl fan-curve -m performance -e true

echo "Repos cloned, reboot first :)"
