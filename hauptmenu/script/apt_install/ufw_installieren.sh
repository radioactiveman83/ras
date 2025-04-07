#!/bin/bash
echo "Starting installation of ufw..."
start_time=$(date +%s)

apt install -y ufw

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "ufw installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),ufw,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "ufw installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),ufw,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of ufw completed."
