#!/bin/bash
echo "Starting installation of iptraf-ng..."
start_time=$(date +%s)

apt install -y iptraf-ng

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "iptraf-ng installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),iptraf-ng,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "iptraf-ng installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),iptraf-ng,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of iptraf-ng completed."
