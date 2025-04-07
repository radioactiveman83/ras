#!/bin/bash
echo "Starting installation of systemd..."
start_time=$(date +%s)

apt install -y systemd

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "systemd installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),systemd,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "systemd installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),systemd,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of systemd completed."
