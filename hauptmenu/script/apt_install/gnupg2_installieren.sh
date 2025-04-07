#!/bin/bash
echo "Starting installation of gnupg2..."
start_time=$(date +%s)

apt install -y gnupg2

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "gnupg2 installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),gnupg2,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "gnupg2 installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),gnupg2,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of gnupg2 completed."
