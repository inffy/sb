#/bin/bash
set -eux

# Don't run this script as root
[ ! "$UID" -eq 0 ] || { echo "This script must not be run as root."; exit 1;}

dconf write /org/gnome/shell/disable-extension-version-validation "true" #yolo
dconf write /org/gnome/shell/disable-user-extensions "false"

gnome-extensions disable background-logo@fedorahosted.org

dconf write /org/gnome/shell/favorite-apps "['org.gnome.Settings.desktop', 'org.gnome.Terminal.desktop', 'org.mozilla.firefox.desktop', 'org.gnome.Evolution.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'org.gnome.TextEditor.desktop', 'com.onepassword.OnePassword.desktop', 'com.discordapp.Discord.desktop', 'org.telegram.desktop.desktop', 'com.irccloud.desktop.desktop', 'io.github.mimbrero.WhatsAppDesktop.desktop', 'org.filezillaproject.Filezilla.desktop', 'org.onlyoffice.desktopeditors.desktop', 'sh.cider.Cider.desktop', 'io.github.shiftey.Desktop.desktop']"

echo "Change to Projects dir"
cd ~/Projects

# Install papirus-icon-theme
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh

echo "Installing oh my bash"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

echo "Fixed, now reboot"
