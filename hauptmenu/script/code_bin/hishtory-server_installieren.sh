#!/bin/bash

# Variables for log files and directories
LOG_DIR="/var/log/install_scripts"
mkdir -p $LOG_DIR
LOGFILE="$LOG_DIR/apt_install.log"
LOGINFILE="$LOG_DIR/login.txt"

# Start time
start_time=$(date +%s)

echo "Installation von hishtory-server wird gestartet..."
# Your installation command
curl -s https://hishtory.dev/install.py | python3 -

# Check if the installation was successful
if [ $? -eq 0 ]; then
    echo "hishtory-server wurde erfolgreich installiert."
    echo "$(date '+%Y-%m-%d %H:%M:%S') hishtory-server erfolgreich $(($(date +%s) - start_time)) Sekunden" >> $LOGFILE
else
    echo "Fehler bei der Installation von hishtory-server."
    echo "$(date '+%Y-%m-%d %H:%M:%S') hishtory-server fehlgeschlagen $(($(date +%s) - start_time)) Sekunden" >> $LOGFILE
fi

echo "Installation von hishtory-server abgeschlossen."
