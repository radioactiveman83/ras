#!/bin/bash
echo "Starting installation of ca-certificates..."
start_time=$(date +%s)

apt install -y ca-certificates

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "ca-certificates installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),ca-certificates,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "ca-certificates installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),ca-certificates,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of ca-certificates completed."
