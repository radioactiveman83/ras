#!/bin/bash
echo "Starting installation of openssh-server..."
start_time=$(date +%s)

apt install -y openssh-server

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "openssh-server installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),openssh-server,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "openssh-server installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),openssh-server,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of openssh-server completed."
