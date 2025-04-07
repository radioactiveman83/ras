#!/bin/bash
echo "Starting installation of tmux..."
start_time=$(date +%s)

apt install -y tmux

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "tmux installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),tmux,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "tmux installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),tmux,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of tmux completed."
