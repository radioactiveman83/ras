#!/bin/bash
echo "Starting installation of hishtory-server..."
start_time=$(date +%s)

curl -s https://hishtory.dev/install.py | python3 -

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "hishtory-server installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),hishtory-server,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "hishtory-server installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),hishtory-server,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of hishtory-server completed."
