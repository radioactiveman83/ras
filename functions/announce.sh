#!/bin/bash
# announce.sh – Funktion zur Ausgabe von Nachrichten
# Diese Funktion gibt die übergebene Nachricht auf der Konsole aus.

announce() {
    echo "$1"
}

# Exportiere die Funktion, damit sie auch in Subshells verfügbar ist
export -f announce
