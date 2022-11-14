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

echo "Switch using ZSH instead of bash"
cd ~/Projects

echo "Clone the dotfiles"
git clone https://github.com/inffy/dotfiles

cd dotfiles

echo "Copy oh-my-zsh confs to home"
cp -r .oh-my-zsh ~/

cd zsh

echo "Copy zsh and p10k configs to home"
cp .zshrc ~/
cp .p10k.zsh ~/

echo "change shell to zsh"
sudo usermod -s /bin/zsh juha

echo "Install needed fonts"
cd ~/Projects/sb
# Fonts
#
# NerdFonts are basically fonts with a more rich set of emojis embeded
mkdir -p ~/.local/share/fonts
curl -sfLo "$HOME/.local/share/fonts/Ubuntu Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete.ttf
curl -sfLo "$HOME/.local/share/fonts/Ubuntu Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Ubuntu/Regular/complete/Ubuntu%20Nerd%20Font%20Complete.ttf
cp -R files/fonts/ubuntu-font-family/*.ttf $HOME/.local/share/fonts/
cp -R files/fonts/meslo/*.ttf $HOME/.local/share/fonts/
# Flush font cache
fc-cache

# Get current profile for terminal, and update the font
current_profile=$(dconf list /org/gnome/terminal/legacy/profiles:/ | head -n1)
# TODO(mc): We /could/ prompt the user if they want to keep the current font, use Ubuntu Mono, or Ubuntu Mono Nerd Font?
dconf write /org/gnome/terminal/legacy/profiles:/${current_profile}use-system-font false
dconf write /org/gnome/terminal/legacy/profiles:/${current_profile}font "'MesloLGS NF 10'"

echo "Done, please reboot!"
