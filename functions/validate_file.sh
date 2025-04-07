#!/bin/bash
# validate_file.sh – Hilfsfunktion: Datei validieren (existiert und nicht leer)
# Diese Funktion prüft, ob die angegebene Datei existiert und nicht leer ist.
#
# Benutzung:
#   validate_file /pfad/zur/datei

validate_file() {
    local file="$1"
    if [ ! -s "$file" ]; then
        echo "ERROR: Datei $file ist leer oder wurde nicht erstellt!" >&2
        exit 1
    else
        echo "VALIDATION: Datei $file wurde erfolgreich erstellt."
    fi
}

export -f validate_file
