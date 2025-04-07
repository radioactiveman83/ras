#!/bin/bash
echo "Starting installation of samba..."
start_time=$(date +%s)

apt install -y samba

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "samba installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),samba,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "samba installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),samba,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of samba completed."
