#!/bin/bash
# menu.sh – Interaktives Hauptmenü mit whiptail
# Dieses Skript zeigt das interaktive Menü und wird von ras.sh aufgerufen.
# Auskommentierte Einträge in hauptmenu.txt werden übersprungen.
/functions/execute_scripts.sh
MENU_DIR="hauptmenu"

while true; do
    options=()
    while IFS= read -r line || [ -n "$line" ]; do
        # Überspringe Zeilen, die mit '#' beginnen (auskommentierte Menüpunkte)
        if [[ "$line" =~ ^[[:space:]]*# ]]; then
            continue
        fi
        option=$(echo "$line" | sed 's/ \[.*//')
        folder=$(echo "$line" | grep -oP '\[\K[^\]]+')
        options+=("$option" "$folder")
    done < "$MENU_DIR/hauptmenu.txt"

    choice=$(whiptail --title "Hauptmenü" --menu "Wähle einen Menüpunkt:" 20 78 10 "${options[@]}" 3>&1 1>&2 2>&3)
    exitstatus=$?
    if [ $exitstatus -ne 0 ]; then
        break
    fi

    selected_folder=""
    while IFS= read -r line || [ -n "$line" ]; do
        # Überspringe auskommentierte Zeilen
        if [[ "$line" =~ ^[[:space:]]*# ]]; then
            continue
        fi
        opt=$(echo "$line" | sed 's/ \[.*//')
        folder=$(echo "$line" | grep -oP '\[\K[^\]]+')
        if [ "$opt" == "$choice" ]; then
            selected_folder=$folder
            break
        fi
    done < "$MENU_DIR/hauptmenu.txt"

    submenu_file="$MENU_DIR/$selected_folder/$selected_folder.txt"

    if [ ! -s "$submenu_file" ]; then
        whiptail --title "$choice" --msgbox "Das Untermenü '$choice' ist leer." 10 50
    else
        checklist_options=()
        while IFS= read -r item || [ -n "$item" ]; do
            checklist_options+=("$item" "" "OFF")
        done < "$submenu_file"

        selected_items=$(whiptail --title "$choice" --checklist "Wähle Einträge aus (Leertaste zum Auswählen):" 20 78 10 "${checklist_options[@]}" 3>&1 1>&2 2>&3)
        whiptail --title "$choice" --msgbox "Ausgewählte Elemente: $selected_items" 10 50
    fi
done

exit 0
