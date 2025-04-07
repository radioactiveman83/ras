#!/bin/bash
echo "Starting installation of vsftpd..."
start_time=$(date +%s)

apt-get install -y vsftpd && cp /etc/vsftpd.conf /etc/vsftpd.conf.bak && sed -i 's/^#listen=YES/listen=YES/' /etc/vsftpd.conf && sed -i 's/^#listen_ipv6=YES/listen_ipv6=NO/' /etc/vsftpd.conf && systemctl restart vsftpd

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "vsftpd installation successful."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),vsftpd,success,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
else
    echo "vsftpd installation failed."
    echo "$(date '+%Y-%m-%d %H:%M:%S'),vsftpd,failure,$(($(date +%s) - start_time)) seconds" >> "/logs/apt_install.log"
fi

echo "Installation of vsftpd completed."
