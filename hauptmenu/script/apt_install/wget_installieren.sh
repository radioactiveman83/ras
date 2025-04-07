#!/bin/bash
echo "Starting installation of wget..."
start_time=$(date +%s)

apt install -y wget

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "wget installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),wget,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "wget installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),wget,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of wget completed."
