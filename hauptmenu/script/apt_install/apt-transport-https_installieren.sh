#!/bin/bash
echo "Starting installation of apt-transport-https..."
start_time=$(date +%s)

apt install -y apt-transport-https

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "apt-transport-https installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),apt-transport-https,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "apt-transport-https installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),apt-transport-https,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of apt-transport-https completed."
