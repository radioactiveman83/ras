#!/bin/bash
echo "Starting installation of glances..."
start_time=$(date +%s)

apt install -y glances

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "glances installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),glances,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "glances installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),glances,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of glances completed."
