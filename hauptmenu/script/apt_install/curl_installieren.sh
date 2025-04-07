#!/bin/bash
echo "Starting installation of curl..."
start_time=$(date +%s)

apt install -y curl

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "curl installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),curl,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "curl installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),curl,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of curl completed."
