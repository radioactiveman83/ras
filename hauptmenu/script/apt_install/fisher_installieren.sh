#!/bin/bash
echo "Starting installation of fisher..."
start_time=$(date +%s)

fisher install jorgebucaran/fisher

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "fisher installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),fisher,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "fisher installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),fisher,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of fisher completed."
