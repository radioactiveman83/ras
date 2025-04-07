#!/bin/bash
echo "Starting installation of mariadb-client..."
start_time=$(date +%s)

apt install -y mariadb-client

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "mariadb-client installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),mariadb-client,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "mariadb-client installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),mariadb-client,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of mariadb-client completed."
