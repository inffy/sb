#!/bin/bash
## Install a base set of bits to mimic the Ubuntu experience
## Intended for Fedora Silverblue and openSUSE MicroOS or Clear Linux
set -eu

echo "Lets install the needed rpmfusion repos"

rpm-ostree install --apply-live \
https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "Lets make rpmfusion repos work better with rebase"
rpm-ostree update \
    --uninstall rpmfusion-free-release-37-0.2.noarch \
    --uninstall rpmfusion-nonfree-release-37-0.2.noarch \
    --install rpmfusion-free-release \
    --install rpmfusion-nonfree-release

echo "I'm DONE! Please reboot!"
