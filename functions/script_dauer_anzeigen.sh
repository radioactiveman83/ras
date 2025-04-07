#!/bin/bash
# script_dauer_anzeigen.sh – Funktion zur Messung der Ausführungsdauer eines anderen Skripts
#
# Verwendung:
#   script_duration <skript> [argumente...]
#
# Beispiel:
#   script_duration ./mein_skript.sh arg1 arg2
#
# Die Funktion misst die Zeit in Sekunden und gibt die Dauer nach Ausführung des Befehls aus.

script_duration() {
    if [ "$#" -eq 0 ]; then
        echo "Usage: script_duration <skript> [argumente...]"
        return 1
    fi

    local start_time=$(date +%s)
    # Führe den übergebenen Befehl inkl. aller Argumente aus
    "$@"
    local exit_code=$?
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    echo "Ausführungsdauer von '$*': $duration Sekunden."
    return $exit_code
}

export -f script_duration
