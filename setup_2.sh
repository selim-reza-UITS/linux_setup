#!/bin/bash

set -e

echo "🧠 [PART 2] Kernel & RAM Optimization"

# Install Liquorix kernel
sudo add-apt-repository -y ppa:damentz/liquorix
sudo apt update
sudo apt install -y linux-image-liquorix-amd64 linux-headers-liquorix-amd64

echo "🚨 Reboot again, then run setup-part3.sh"

