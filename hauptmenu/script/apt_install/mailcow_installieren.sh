#!/bin/bash
echo "Starting installation of mailcow..."
start_time=$(date +%s)

mkdir -p /opt && cd /opt && git clone https://github.com/mailcow/mailcow-dockerized.git /opt/mailcow-dockerized && cd /opt/mailcow-dockerized && ./generate_config.sh && sed -i 's/^MAILCOW_HOSTNAME=.*/MAILCOW_HOSTNAME=$HOST/' mailcow.conf && sed -i 's/^HTTP_PORT=.*/HTTP_PORT=8080/' mailcow.conf && sed -i 's/^HTTP_BIND=.*/HTTP_BIND=0.0.0.0/' mailcow.conf && sed -i 's/^HTTPS_PORT=.*/HTTPS_PORT=8443/' mailcow.conf && sed -i 's/^HTTPS_BIND=.*/HTTPS_BIND=0.0.0.0/' mailcow.conf && docker compose pull && docker compose up -d

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "mailcow installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),mailcow,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "mailcow installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),mailcow,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of mailcow completed."
