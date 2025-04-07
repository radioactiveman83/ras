#!/bin/bash
echo "Starting installation of python3..."
start_time=$(date +%s)

apt install -y python3

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "python3 installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),python3,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "python3 installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),python3,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of python3 completed."
