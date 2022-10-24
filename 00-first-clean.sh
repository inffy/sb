## Intended for Fedora Silverblue and openSUSE MicroOS or Clear Linux
set -eu

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1;} # Need to figure out how to pkexec so we only ask for the password once.

BITS=./bits
source $BITS/common

# Remove the useless fedora flatpak repo
echo "Removing flatpaks"
flatpak remove --all
echo "remove fedora flatpak repo"
flatpak remote-delete fedora

echo "Repo removed"
