#!/bin/bash
echo "Starting installation of build-essential..."
start_time=$(date +%s)

apt install -y build-essential

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "build-essential installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),build-essential,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "build-essential installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),build-essential,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of build-essential completed."
