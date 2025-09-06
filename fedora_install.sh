#!/bin/bash

# Update system
dnf update -y

# Remove unnecessary packages
dnf remove firefox gnome-weather gnome-clocks gnome-contacts cheese gnome-tour gnome-music gnome-calendar yelp xsane totem snapshot epiphany libreoffice-impress libreoffice-writer libreoffice-calc -y

# Install required packages and enable repos
sudo dnf install dnf-plugins-core -y
sudo dnf copr enable dwrobel/python-Yapps2 -y
sudo dnf copr enable dwrobel/linuxcnc -y

# Add CentOS kernel-rt repository
sudo wget -O /etc/yum.repos.d/rt.repo https://dwrobel.fedorapeople.org/tmp/linuxcnc/rt.repo

# Install CentOS GPG keys
sudo dnf install https://mirror.karneval.cz/pub/linux/centos-stream/9-stream/BaseOS/x86_64/os/Packages/centos-gpg-keys-9.0-23.el9.noarch.rpm -y

# Install linuxcnc
sudo dnf install linuxcnc-uspace -y

# Add user to realtime group
sudo usermod -a -G realtime $(whoami)

# Install VSCodium
rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h\n" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo dnf install codium -y

echo "Installation complete! Please reboot your system to apply all changes."
echo "Run: sudo reboot"