# Integrations
# Stuff that works but probably needs a cleaner way to install

# Wallpaper
#
# Set a community wallpaper
set -eux

# Fonts
#
# NerdFonts are basically fonts with a more rich set of emojis embeded
mkdir -p ~/.local/share/fonts
curl -sfLo "$HOME/.local/share/fonts/Ubuntu Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete.ttf
curl -sfLo "$HOME/.local/share/fonts/Ubuntu Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Ubuntu/Regular/complete/Ubuntu%20Nerd%20Font%20Complete.ttf
cp -R files/fonts/ubuntu-font-family/*.ttf $HOME/.local/share/fonts/
# Flush font cache
fc-cache

# Get current profile for terminal, and update the font
current_profile=$(dconf list /org/gnome/terminal/legacy/profiles:/ | head -n1)
# TODO(mc): We /could/ prompt the user if they want to keep the current font, use Ubuntu Mono, or Ubuntu Mono Nerd Font?
dconf write /org/gnome/terminal/legacy/profiles:/${current_profile}use-system-font false
dconf write /org/gnome/terminal/legacy/profiles:/${current_profile}font "'UbuntuMono Nerd Font 12'"

# Make distrobox images and shortcuts
# Thanks @89luca89
# This isn't idempotent!
# So if you mess this up run `dconf reset -f /org/gnome/terminal/legacy/profiles:/`
# to reset the profiles back to default

# Lets be brave and use Fedora rawhide
distrobox-create -Y -i registry.fedoraproject.org/fedora-toolbox:rawhide --name fedora-tb

# also create Arch distrobox
distrobox-create -Y -i docker.io/library/archlinux:latest --name arch-tb

# Add keyb shortcuts to Gnome
echo "Creating shortcuts for the Fedora distrobox"

./bits/distrobox-terminal-profile.sh -n fedora-tb -c fedora-tb -s "<Primary><Alt>f"

echo "Creating shortcuts for Arch distrobox"
./bits/distrobox-terminal-profile.sh -n arch-tb -c arch-tb -s "<Primary><Alt>a"

echo "Done!"
