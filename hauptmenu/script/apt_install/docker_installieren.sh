#!/bin/bash
echo "Starting installation of docker..."
start_time=$(date +%s)

mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null && apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "docker installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),docker,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "docker installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),docker,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of docker completed."
