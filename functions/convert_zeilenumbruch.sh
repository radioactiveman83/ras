#!/bin/bash

# Funktion zur Konvertierung der Zeilenumbrüche in Shell-Skripten
convert_zeilenumbruch() {
    # Suche alle .sh Dateien rekursiv im gegebenen Verzeichnis
    find /hauptmenu/script -type f -name "*.sh" -print0 | while IFS= read -r -d $'\0' file; do
        echo "Konvertiere Zeilenumbrüche in: $file"
        # Anwenden des sed-Befehls, um Windows-Zeilenumbrüche zu entfernen
        sed -i 's/\r$//' "$file"
    done
}

# Aufruf der Funktion
convert_zeilenumbruch
