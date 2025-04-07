#!/bin/bash
# deutsch_einstellen.sh – Skript zur Systemlokalisierung und Zeitzoneneinstellung
# Dieses Skript aktualisiert das System, installiert und konfiguriert die deutschen Locale-Einstellungen
# und stellt die Zeitzone auf Europe/Berlin ein.

# Prüfen, ob das Skript als Root ausgeführt wird
if [ "$(id -u)" -ne 0 ]; then
    echo "Bitte führe das Skript als Root oder mit sudo aus."
    exit 1
fi

# Systemupdate und -upgrade
apt-get update && apt-get upgrade -y

# Installation der Locales
apt-get install -y locales

# Aktivieren des deutschen Locale (de_DE.UTF-8)
sed -i 's/^# *de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen

# Generieren der Locale-Einstellungen
locale-gen

# Setzen der Standard-Locale auf de_DE.UTF-8
update-locale LANG=de_DE.UTF-8

# Einstellen der Zeitzone auf Europe/Berlin
timedatectl set-timezone Europe/Berlin
