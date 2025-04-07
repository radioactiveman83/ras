#!/bin/bash


INFO_DIR="/hauptmenu/info"
mkdir -p $INFO_DIR


# Variables for log files and directories
LOG_DIR="/var/log/install_scripts"
mkdir -p $LOG_DIR
LOGFILE="$LOG_DIR/apt_install.log"
LOGINFILE="$LOG_DIR/login.txt"

# Start time
start_time=$(date +%s)

echo "Installation von hishtory wird gestartet..."
# Installation command
apt install -y hishtory

# Check if the installation was successful
if [ $? -eq 0 ]; then
    echo "hishtory wurde erfolgreich installiert."
    echo "$(date '+%Y-%m-%d %H:%M:%S') hishtory erfolgreich $(($(date +%s) - start_time)) Sekunden" >> $LOGFILE
    echo "hishtory" >> $INFO_DIR/installed_apps_list.txt
else
    echo "Fehler bei der Installation von hishtory."
    echo "$(date '+%Y-%m-%d %H:%M:%S') hishtory fehlgeschlagen $(($(date +%s) - start_time)) Sekunden" >> $LOGFILE
fi

echo "Installation von hishtory abgeschlossen."


display_hishtory_stats() {
    if command -v hishtory >/dev/null; then
        echo "Anzeige der Hishtory Statistiken:"
        hishtory --stats
    else
        echo "Hishtory ist nicht installiert."
    fi
}

display_hishtory_stats
