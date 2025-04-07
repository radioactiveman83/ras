#!/bin/bash
echo "Starting installation of git..."
start_time=$(date +%s)

apt install -y git

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "git installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),git,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "git installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),git,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of git completed."
