#!/bin/bash
echo "Starting installation of lsb-release..."
start_time=$(date +%s)

apt install -y lsb-release

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "lsb-release installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),lsb-release,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "lsb-release installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),lsb-release,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of lsb-release completed."
