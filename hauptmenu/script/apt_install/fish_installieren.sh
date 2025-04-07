#!/bin/bash
echo "Starting installation of fish..."
start_time=$(date +%s)

apt update && apt install -y fish

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "fish installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),fish,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "fish installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),fish,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of fish completed."
