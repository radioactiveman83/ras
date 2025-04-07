#!/bin/bash
# header.sh – Header-Funktion (max. 15 Zeilen)
# Diese Funktion "announce" fügt eine übergebene Nachricht in einen fortlaufenden Header ein,
# der maximal 15 Zeilen umfasst, und zeigt diesen oben im Terminal an.
#
# Benutzung:
#   announce "Ihre Nachricht"
# Hinweis: Bitte setzen Sie SLEEP_TIME (z. B.: export SLEEP_TIME=1), bevor Sie diese Funktion verwenden.

HEADER=""

announce() {
    local new_line
    new_line="$(echo -e "\033[32m$1\033[0m")"
    HEADER="${HEADER:+$HEADER$'\n'}$new_line"
    local num_lines
    num_lines=$(echo "$HEADER" | wc -l)
    while [ "$num_lines" -gt 15 ]; do
        HEADER=$(echo "$HEADER" | sed '1d')
        num_lines=$(echo "$HEADER" | wc -l)
    done
    for (( i=0; i<num_lines; i++ )); do
        tput cup $i 0
        tput el
    done
    tput cup 0 0
    echo -e "$HEADER"
    tput csr "$num_lines" "$(tput lines)"
    tput cup "$num_lines" 0
    tput ed
    sleep "$SLEEP_TIME"
}

export -f announce
