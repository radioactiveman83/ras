#!/bin/bash
echo "Starting installation of make..."
start_time=$(date +%s)

apt install -y make

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "make installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),make,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "make installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),make,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of make completed."
