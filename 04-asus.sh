#!/bin/bash
# Get the needes asus repos for S3 patch and stuff
set -eu

# Start the supergfx daemon
sudo systemctl enable --now supergfxd

# Change directory to ~/Projects
cd ~/Projects

# clone the asus misc stuff repo
git clone https://gitlab.com/marcaux/asus-g14-2022

echo "Repos cloned, reboot first :)"
