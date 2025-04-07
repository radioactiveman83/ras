#!/bin/bash
echo "Starting installation of p7zip-full..."
start_time=$(date +%s)

apt install -y p7zip-full

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "p7zip-full installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),p7zip-full,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "p7zip-full installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),p7zip-full,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of p7zip-full completed."
