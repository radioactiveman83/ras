#!/bin/bash
echo "Starting installation of starship..."
start_time=$(date +%s)

curl -sS https://starship.rs/install.sh | sh -s -- -y

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "starship installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),starship,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "starship installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),starship,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of starship completed."
