#!/bin/bash
# execute_scripts.sh – Funktion zum Ausführbarmachen aller .sh Dateien in $MENU_DIR und allen Unterverzeichnissen
#
# Benutzung:
#   source /pfad/zu/execute_scripts.sh
#   execute_scripts
#
# Hinweis: Stelle sicher, dass die Variable MENU_DIR gesetzt ist, bevor Du die Funktion aufrufst.
define MENU_DIR="./"
execute_scripts() {
    if [ -z "$MENU_DIR" ]; then
        echo "Fehler: Variable MENU_DIR ist nicht gesetzt."
        return 1
    fi

    echo "Mache alle .sh Dateien in $MENU_DIR und seinen Unterverzeichnissen ausführbar..."
    find "$MENU_DIR" -type f -name "*.sh" -exec chmod +x {} \;
    echo "Fertig: Alle .sh Dateien in $MENU_DIR und Unterverzeichnissen sind jetzt ausführbar."
}

export -f execute_scripts
