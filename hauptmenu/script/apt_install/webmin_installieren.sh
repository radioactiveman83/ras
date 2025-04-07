#!/bin/bash
echo "Starting installation of webmin..."
start_time=$(date +%s)

curl -o webmin-setup-repo.sh https://raw.githubusercontent.com/webmin/webmin/master/webmin-setup-repo.sh && bash webmin-setup-repo.sh && apt-get install -y webmin --install-recommends

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "webmin installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),webmin,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "webmin installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),webmin,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of webmin completed."
