#!/bin/bash

set -e

echo "🧩 [PART 3] Final Setup – zswap, Docker, Flatpaks"

# Enable zswap in GRUB
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="zswap.enabled=1 /' /etc/default/grub
sudo update-grub

# Install Flatpak apps
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.getpostman.Postman
flatpak install -y flathub ch.tlaun.TL

# Docker cleanup
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do 
  sudo apt-get remove -y $pkg || true
done

# Docker install
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "✅ All parts complete! Your system is ready. 🎉"

