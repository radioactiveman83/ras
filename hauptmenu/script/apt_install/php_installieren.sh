#!/bin/bash
echo "Starting installation of php..."
start_time=$(date +%s)

apt install -y php

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "php installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),php,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "php installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),php,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of php completed."
