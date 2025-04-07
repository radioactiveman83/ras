#!/bin/bash
# hostname_aendern.sh – Skript zum Ändern des Hostnamens
# Dieses Skript liest einen neuen Hostnamen ein, ändert diesen über hostnamectl
# und gibt eine entsprechende Bestätigung aus.
# Die Funktion "announce" wird aus dem Skript $FUNC_DIR/announce.sh geladen.

# Prüfen, ob die Variable FUNC_DIR gesetzt ist
if [ -z "$FUNC_DIR" ]; then
    echo "Variable FUNC_DIR ist nicht gesetzt. Bitte setzen Sie FUNC_DIR, bevor Sie dieses Skript ausführen."
    exit 1
fi

# Lade die announce-Funktion aus dem Skript im Verzeichnis $FUNC_DIR
source "$FUNC_DIR/announce.sh"

read -rp "Bitte geben Sie den gewünschten neuen Hostnamen ein (oder drücken Sie Enter, um den aktuellen zu behalten): " NEW_HOSTNAME
if [ -n "$NEW_HOSTNAME" ]; then
    hostnamectl set-hostname "$NEW_HOSTNAME"
    HOST=$(hostname)
    announce "Hostname wurde auf $HOST geändert."
else
    HOST=$(hostname)
    announce "Kein neuer Hostname eingegeben, verwende den aktuellen Hostnamen: $HOST"
fi
export HOST
source ./export_variables.sh
export_all_variables