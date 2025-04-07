#!/bin/bash
echo "Starting installation of unzip..."
start_time=$(date +%s)

apt install -y unzip

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "unzip installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),unzip,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "unzip installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),unzip,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of unzip completed."
