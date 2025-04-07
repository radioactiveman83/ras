#!/bin/bash
echo "Starting installation of shellinabox..."
start_time=$(date +%s)

apt install -y shellinabox

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "shellinabox installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),shellinabox,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "shellinabox installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),shellinabox,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of shellinabox completed."
