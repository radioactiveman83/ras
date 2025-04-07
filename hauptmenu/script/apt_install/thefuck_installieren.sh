#!/bin/bash
echo "Starting installation of thefuck..."
start_time=$(date +%s)

pip3 install thefuck

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "thefuck installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),thefuck,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "thefuck installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),thefuck,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of thefuck completed."
