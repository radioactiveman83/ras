#!/bin/bash

# Überprüfe, ob Python3 installiert ist
if ! command -v python3 &>/dev/null; then
    echo "Python3 ist nicht installiert. Bitte installiere Python3."
    exit 1
fi

# Installiere Python-Abhängigkeiten
echo "Installiere benötigte Python-Pakete..."
pip3 install beautifulsoup4 requests

# Führe das Python-Skript aus
python3 get_docker_compose.py
