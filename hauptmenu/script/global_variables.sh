#!/bin/bash

# Definiere HOST_ORIG und SERVER_IP als schreibgeschützte Variablen
readonly HOST_ORIG="$(hostname)"
readonly SERVER_IP="$(hostname -I | awk '{print $1}')"
export SERVER_IP

# Eingabeaufforderung für den Benutzernamen, wenn nicht bereits gesetzt
if [[ -z "${USERNAME:-}" ]]; then
    read -rp "Bitte geben Sie den Benutzernamen ein (z.B. locadmin): " USERNAME
fi

# Eingabeaufforderung für das Benutzerpasswort, wenn nicht bereits gesetzt
if [[ -z "${USER_PASSWORD:-}" ]]; then
    read -rsp "Bitte geben Sie das Passwort für den Benutzer $USERNAME ein: " USER_PASSWORD
    echo ""
fi

# Definiere SCRIPTNAME als schreibgeschützte Variable
readonly SCRIPTNAME="$(basename "$0")"

# Exportiere notwendige Variablen für die Nutzung in anderen Skripten
export HOST_ORIG SERVER_IP USERNAME USER_PASSWORD SCRIPTNAME

# Optional: Exportiere eine Variable SLEEP_TIME, falls benötigt
readonly SLEEP_TIME=10
export SLEEP_TIME
