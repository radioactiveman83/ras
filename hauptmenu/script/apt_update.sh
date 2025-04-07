#!/bin/bash

# Sicherstellen, dass das Skript als Root ausgeführt wird
if [ "$EUID" -ne 0 ]; then
    echo "Bitte als Root ausführen."
    exit
fi

echo "Starte Systemaktualisierung..."

# Systemaktualisierungen durchführen
apt update -y
apt upgrade -y

# Nicht mehr benötigte Pakete entfernen
apt autoremove -y

echo "Systemaktualisierung abgeschlossen."
