#!/bin/bash
# load_variables.sh – Funktion zum Laden der in variables.txt gespeicherten Variablen
# Diese Funktion ermöglicht es allen Skripten, die exportierten Variablen, die in
# $VAR_DIR/variables.txt gespeichert wurden, zu verwenden.

load_variables() {
    # Prüfe, ob VAR_DIR gesetzt ist
    if [ -z "$VAR_DIR" ]; then
        echo "ERROR: VAR_DIR ist nicht gesetzt. Bitte setzen Sie VAR_DIR, bevor Sie load_variables aufrufen." >&2
        return 1
    fi

    local varfile="$VAR_DIR/variables.txt"

    # Prüfe, ob die Datei existiert und nicht leer ist
    if [ ! -s "$varfile" ]; then
        echo "ERROR: Datei $varfile existiert nicht oder ist leer!" >&2
        return 1
    fi

    # Lade die in der Datei gespeicherten Variablen in die aktuelle Umgebung
    # Die Datei wurde zuvor über 'declare -p' erstellt und enthält gültige Shell-Syntax
    source "$varfile"

    echo "Die in $varfile gespeicherten Variablen wurden geladen."
    return 0
}

export -f load_variables
