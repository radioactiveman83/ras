#!/bin/bash
echo "Starting installation of bash..."
start_time=$(date +%s)

apt install -y bash

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "bash installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),bash,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "bash installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),bash,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of bash completed."
