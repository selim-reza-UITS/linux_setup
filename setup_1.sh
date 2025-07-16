#!/bin/bash

set -e

echo "🛠️ [PART 1] Base System Setup"

# Update & upgrade
sudo apt update && sudo apt upgrade -y

# Multimedia codecs
sudo apt install -y ubuntu-restricted-extras

# GNOME: minimize on dock click
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# GNOME Tweak Tool
sudo apt install -y gnome-tweak-tool

# Flatpak & Flathub
sudo apt install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# apt-fast
sudo add-apt-repository -y ppa:apt-fast/stable
sudo apt update
sudo apt install -y apt-fast

# CLI tools
sudo apt install -y nano vim git zsh curl gdebi gedit preload

# Remove Snap
sudo systemctl stop snapd
sudo apt purge -y snapd
sudo rm -rf ~/snap /snap /var/snap /var/lib/snapd

# Install Chrome & VS Code from Downloads
sudo apt install -y ~/Downloads/google-chrome*.deb || echo "⚠️ Chrome not found"
sudo apt install -y ~/Downloads/code*.deb || echo "⚠️ VS Code not found"

# Install Breeze Snow cursor
sudo apt install -y breeze-cursor-theme
gsettings set org.gnome.desktop.interface cursor-theme 'Breeze_Snow'

# Install UV
curl -LsSf https://astral.sh/uv/install.sh | sh
uv python install 3.11
uv python install 3.12

# Swapspace for dynamic swap
sudo apt install -y swapspace

echo "🚨 Reboot required before running setup-part2.sh"

