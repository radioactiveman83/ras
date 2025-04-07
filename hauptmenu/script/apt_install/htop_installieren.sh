#!/bin/bash
echo "Starting installation of htop..."
start_time=$(date +%s)

apt install -y htop

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "htop installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),htop,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "htop installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),htop,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of htop completed."
