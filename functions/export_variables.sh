#!/bin/bash
# export_variables.sh – Funktion zum Exportieren aller bisher genutzten Variablen
# In die Datei $VAR_DIR/variables.txt werden alle Shell-Variablen (ohne Funktionen) geschrieben.
# Vor Verwendung sicherstellen, dass die Variable VAR_DIR gesetzt ist (z. B.: export VAR_DIR="/pfad/zum/verzeichnis")

export_all_variables() {
    # Prüfen, ob VAR_DIR gesetzt ist
    if [ -z "$VAR_DIR" ]; then
        echo "Fehler: VAR_DIR ist nicht gesetzt. Bitte VAR_DIR auf ein gültiges Verzeichnis setzen."
        return 1
    fi

    # Erstelle das Verzeichnis, falls es nicht existiert
    mkdir -p "$VAR_DIR"

    # Exportiere alle Variablen (ohne Funktionen) in die Datei variables.txt
    # "declare -p" listet alle Variablen auf; mit grep werden Funktionsdefinitionen herausgefiltert.
    declare -p | grep -v '^declare -f' > "$VAR_DIR/variables.txt"

    echo "Alle Variablen wurden in $VAR_DIR/variables.txt exportiert."
}

# Exportiere die Funktion, falls sie in Subshells benötigt wird
export -f export_all_variables
