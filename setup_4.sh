#!/bin/bash

set -e

echo "🧹 [PART 4] Cleaning & Optimizing Ubuntu Boot and Startup"

# ------------------------------------
# STEP 1: Disable GRUB Boot Delay
# ------------------------------------
echo "⏱️ Removing GRUB timeout (boot menu wait)..."
sudo sed -i 's/^GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=0/' /etc/default/grub
sudo sed -i 's/^GRUB_TIMEOUT_STYLE=.*$/GRUB_TIMEOUT_STYLE=hidden/' /etc/default/grub
sudo update-grub

# ------------------------------------
# STEP 2: Remove Boot Splash Screen
# ------------------------------------
echo "🖼️ Removing splash screen from boot..."
sudo sed -i 's/quiet splash/quiet/' /etc/default/grub
sudo update-grub

# Optional: for a totally text-only boot experience, use this instead:
# sudo sed -i 's/quiet splash//g' /etc/default/grub

# ------------------------------------
# STEP 3: Disable Unnecessary Startup Applications
# ------------------------------------
echo "🚫 Disabling unnecessary startup apps..."

# Create ~/.config if missing
mkdir -p ~/.config/autostart

# List startup apps (GUI ones are hidden by default)
startup_apps=$(ls /etc/xdg/autostart/)

# Disable apps by copying and marking them hidden
for app in $startup_apps; do
    cp /etc/xdg/autostart/$app ~/.config/autostart/
    echo "Hidden=true" >> ~/.config/autostart/$app
done

echo "✅ All default startup apps disabled (can re-enable from GNOME Tweaks > Startup Apps)"

# ------------------------------------
# STEP 4: Remove Unused Packages
# ------------------------------------
echo "🧼 Running apt autoremove..."
sudo apt autoremove -y
sudo apt clean

# ------------------------------------
# STEP 5: Optional - Remove Crash Reporting
# ------------------------------------
echo "🚫 Disabling crash reports..."
sudo systemctl disable apport.service
sudo systemctl mask apport.service

echo 'vm.swappiness=20' | sudo tee /etc/sysctl.d/99-swappiness.conf
sudo sysctl -p /etc/sysctl.d/99-swappiness.conf

sudo apt update
sudo reboot

echo "✅ Cleanup complete! Please reboot to see the changes."

