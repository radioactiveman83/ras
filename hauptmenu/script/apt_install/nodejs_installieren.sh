#!/bin/bash
echo "Starting installation of nodejs..."
start_time=$(date +%s)

apt install -y nodejs

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "nodejs installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),nodejs,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "nodejs installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),nodejs,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of nodejs completed."
