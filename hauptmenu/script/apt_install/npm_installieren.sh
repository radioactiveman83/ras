#!/bin/bash
echo "Starting installation of npm..."
start_time=$(date +%s)

apt install -y npm

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "npm installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),npm,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "npm installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),npm,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of npm completed."
