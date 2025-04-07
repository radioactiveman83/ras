#!/bin/bash
echo "Starting installation of iftop..."
start_time=$(date +%s)

apt install -y iftop

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "iftop installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),iftop,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "iftop installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),iftop,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of iftop completed."
