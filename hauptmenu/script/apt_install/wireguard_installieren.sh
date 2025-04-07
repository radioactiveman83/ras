#!/bin/bash
echo "Starting installation of wireguard..."
start_time=$(date +%s)

apt install -y wireguard

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "wireguard installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),wireguard,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "wireguard installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),wireguard,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of wireguard completed."
