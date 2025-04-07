#!/bin/bash

# Variables for log files and directories
LOG_DIR="/var/log/install_scripts"
mkdir -p $LOG_DIR
LOGFILE="$LOG_DIR/apt_install.log"
LOGINFILE="$LOG_DIR/login.txt"

# Start time
start_time=$(date +%s)

echo "Installation von install wird gestartet..."
# Installation command
echo 'Install command is usually part of coreutils and should already be installed.'

# Check if the installation was successful
if [ $? -eq 0 ]; then
    echo "install wurde erfolgreich installiert."
    echo "$(date '+%Y-%m-%d %H:%M:%S') install erfolgreich $(($(date +%s) - start_time)) Sekunden" >> $LOGFILE
else
    echo "Fehler bei der Installation von install."
    echo "$(date '+%Y-%m-%d %H:%M:%S') install fehlgeschlagen $(($(date +%s) - start_time)) Sekunden" >> $LOGFILE
fi

echo "Installation von install abgeschlossen."

# Display Hishtory statistics
echo "Anzeigen von Hishtory-Statistiken zum Durchlauf:"
hishtory summarize --session
