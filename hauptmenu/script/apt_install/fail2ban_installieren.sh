#!/bin/bash
echo "Starting installation of fail2ban..."
start_time=$(date +%s)

apt install -y fail2ban

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "fail2ban installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),fail2ban,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "fail2ban installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),fail2ban,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of fail2ban completed."
