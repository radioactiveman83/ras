#!/bin/bash
echo "Starting installation of certbot..."
start_time=$(date +%s)

apt install -y certbot

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "certbot installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),certbot,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "certbot installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),certbot,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of certbot completed."
