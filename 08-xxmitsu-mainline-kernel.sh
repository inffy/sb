#!/bin/bash
# Get the newest 6.1 kernel from copr
set -eu

echo "Downloading the xxmitsu copr repo file"
cd /etc/yum.repos.d/
sudo wget https://copr.fedorainfracloud.org/coprs/xxmitsu/kernel-fedora/repo/fedora-37/xxmitsu-kernel-fedora-fedora-37.repo

echo "Installing the kernel from https://copr.fedorainfracloud.org/coprs/xxmitsu/kernel-fedora/" 
sudo rpm-ostree override replace --experimental --from repo=copr:copr.fedorainfracloud.org:xxmitsu:kernel-fedora kernel kernel-core kernel-modules kernel-modules-extra
