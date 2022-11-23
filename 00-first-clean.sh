## Intended for Fedora Silverblue and openSUSE MicroOS or Clear Linux
set -eu

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1;} # Need to figure out how to pkexec so we only ask for the password once.

BITS=./bits
source $BITS/common

# Enable flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Reinstall all the flatpaks from the fedora repo, so that they get installed from flathub
flatpak install --reinstall flathub $(flatpak list --app-runtime=org.fedoraproject.Platform --columns=application | tail -n +1 )

# Remove the useless fedora flatpak repo
flatpak remote-delete fedora

echo "Repo removed"
