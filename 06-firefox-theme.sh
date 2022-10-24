set -eux

echo "Lets install the nice gnome firefox theme"

echo "Git clone the ff theme repo and cd to it"
cd ~/Projects/
git clone https://github.com/rafaelmardojai/firefox-gnome-theme && cd firefox-gnome-theme

echo "Lets install the theme"
./scripts/auto-install.sh

echo "Theme installed, restart firefox"
