#!/bin/bash
echo "Starting installation of whiptail..."
start_time=$(date +%s)

apt install -y whiptail

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "whiptail installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),whiptail,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "whiptail installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),whiptail,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of whiptail completed."
