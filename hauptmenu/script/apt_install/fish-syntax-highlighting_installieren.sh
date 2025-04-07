#!/bin/bash
echo "Starting installation of fish-syntax-highlighting..."
start_time=$(date +%s)

fisher install PatrickF1/fzf.fish

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "fish-syntax-highlighting installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),fish-syntax-highlighting,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "fish-syntax-highlighting installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),fish-syntax-highlighting,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of fish-syntax-highlighting completed."
