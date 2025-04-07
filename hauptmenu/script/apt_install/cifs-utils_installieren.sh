#!/bin/bash
echo "Starting installation of cifs-utils..."
start_time=$(date +%s)

apt install -y cifs-utils

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "cifs-utils installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),cifs-utils,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "cifs-utils installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),cifs-utils,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of cifs-utils completed."
