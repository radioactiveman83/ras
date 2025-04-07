#!/bin/bash
echo "Starting installation of tailscale..."
start_time=$(date +%s)

apt install -y tailscale

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "tailscale installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),tailscale,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "tailscale installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),tailscale,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of tailscale completed."
