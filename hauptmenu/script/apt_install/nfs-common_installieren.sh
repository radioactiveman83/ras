#!/bin/bash
echo "Starting installation of nfs-common..."
start_time=$(date +%s)

apt install -y nfs-common

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "nfs-common installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),nfs-common,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "nfs-common installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),nfs-common,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of nfs-common completed."
