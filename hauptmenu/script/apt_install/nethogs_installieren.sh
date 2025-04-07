#!/bin/bash
echo "Starting installation of nethogs..."
start_time=$(date +%s)

apt install -y nethogs

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "nethogs installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),nethogs,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "nethogs installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),nethogs,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of nethogs completed."
