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

echo "Done!"
