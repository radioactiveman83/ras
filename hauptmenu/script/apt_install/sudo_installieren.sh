#!/bin/bash
echo "Starting installation of sudo..."
start_time=$(date +%s)

apt install -y sudo

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "sudo installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),sudo,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "sudo installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),sudo,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of sudo completed."
