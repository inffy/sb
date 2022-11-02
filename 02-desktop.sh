#/bin/bash
set -eux

# Don't run this script as root
[ ! "$UID" -eq 0 ] || { echo "This script must not be run as root."; exit 1;}

gnome-extensions disable background-logo@fedorahosted.org
dconf write /org/gnome/shell/disable-extension-version-validation "true" #yolo
dconf write /org/gnome/shell/disable-user-extensions "false"
dconf write /org/gnome/desktop/privacy/send-software-usage-stats "false"
dconf write /org/gnome/software/allow-updates "false"
dconf write /org/gnome/software/download-updates "false"
dconf write /org/gnome/software/download-updates-notify "false"

dconf write /org/gnome/shell/favorite-apps "['org.gnome.Settings.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'com.onepassword.OnePassword.desktop', 'org.mozilla.Thunderbird.desktop', 'org.mozilla.firefox.desktop', 'org.gnome.TextEditor.desktop', 'com.discordapp.Discord.desktop', 'org.telegram.desktop.desktop', 'io.github.mimbrero.WhatsAppDesktop.desktop', 'com.irccloud.desktop.desktop', 'im.riot.Riot.desktop', 'com.slack.Slack.desktop', 'org.filezillaproject.Filezilla.desktop', 'org.onlyoffice.desktopeditors.desktop', 'sh.cider.Cider.desktop', 'io.github.shiftey.Desktop.desktop', 'com.google.Chrome.desktop', 'com.microsoft.Edge.desktop', 'org.gimp.GIMP.desktop']"

echo "Change to Projects dir"
cd ~/Projects

# Install papirus-icon-theme
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh

echo "Install nord theme for Gnome-terminal"
cd ~/Projects
git clone https://github.com/arcticicestudio/nord-gnome-terminal.git
cd nord-gnome-terminal/src

echo "Installing to default profile"
./nord.sh -p default



