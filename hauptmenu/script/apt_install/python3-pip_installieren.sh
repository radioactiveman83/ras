#!/bin/bash
echo "Starting installation of python3-pip..."
start_time=$(date +%s)

apt install -y python3-pip

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "python3-pip installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),python3-pip,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "python3-pip installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),python3-pip,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of python3-pip completed."
