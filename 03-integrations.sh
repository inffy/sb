# Integrations
# Stuff that works but probably needs a cleaner way to install

# Wallpaper
#
# Set a community wallpaper
set -eux

# Make distrobox images and shortcuts
# Thanks @89luca89
# This isn't idempotent!
# So if you mess this up run `dconf reset -f /org/gnome/terminal/legacy/profiles:/`
# to reset the profiles back to default

# Create Fedora 37 toolbox
distrobox-create -Y -i fedora:37 --name fedora-tb

# also create Arch distrobox
distrobox-create -Y -i docker.io/library/alpine:latest --name alpine-tb

# Add keyb shortcuts to Gnome
echo "Creating shortcuts for the Fedora distrobox"

./bits/distrobox-terminal-profile.sh -n fedora-tb -c fedora-tb -s "<Primary><Alt>f"

echo "Creating shortcuts for Arch distrobox"
./bits/distrobox-terminal-profile.sh -n alpine-tb -c alpine-tb -s "<Primary><Alt>a"

echo "Done!"
