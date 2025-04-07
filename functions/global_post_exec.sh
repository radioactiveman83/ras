#!/usr/bin/env bash
# global_post_exec.sh – Globales Post-Execution-Skript (Bash/Fish)
# Diese Datei wird automatisch in jedem non-interaktiven Skript geladen (z. B. via BASH_ENV).
# Sie zeigt eine Checkliste aller in $FUNC_DIR vorhandenen Funktionsskripte an (außer global_post_exec.sh),
# lädt die ausgewählten Funktionen und speichert deren Namen. Beim Skriptende wird per EXIT-Trap eine Checkliste der
# geladenen Funktionen angezeigt, sodass Du auswählen kannst, welche Funktionen ausgeführt werden sollen.

if [ -n "$BASH_VERSION" ]; then
    # --- Bash-Version ---
    if [ -z "$GLOBAL_POST_EXEC_INITIALIZED" ]; then
        GLOBAL_POST_EXEC_INITIALIZED=1

        if [ -z "$FUNC_DIR" ]; then
            echo "ERROR: Variable FUNC_DIR ist nicht gesetzt. Bitte setzen Sie FUNC_DIR, bevor Sie fortfahren." >&2
            exit 1
        fi

        # Ermitteln aller .sh Dateien in $FUNC_DIR (nur oberste Ebene) und global_post_exec.sh ausschließen
        func_files=()
        for file in "$FUNC_DIR"/*.sh; do
            if [ "$(basename "$file")" = "global_post_exec.sh" ]; then
                continue
            fi
            func_files+=("$file")
        done

        if [ ${#func_files[@]} -eq 0 ]; then
            echo "Keine Funktionsdateien in \$FUNC_DIR gefunden."
        fi

        options=()
        for file in "${func_files[@]}"; do
            func_name=$(basename "$file" .sh)
            options+=("$func_name" "Lade $func_name" "ON")
        done

        selected=$(whiptail --title "Funktionen laden" \
          --checklist "Wählen Sie die Funktionen, die geladen werden sollen:" 20 78 10 \
          "${options[@]}" 3>&1 1>&2 2>&3)

        LOADED_FUNCTIONS=()
        for func in $selected; do
            func=$(echo "$func" | sed 's/"//g')
            LOADED_FUNCTIONS+=("$func")
        done

        for func in "${LOADED_FUNCTIONS[@]}"; do
            if [ -f "$FUNC_DIR/$func.sh" ]; then
                source "$FUNC_DIR/$func.sh"
            else
                echo "WARNUNG: Datei \$FUNC_DIR/$func.sh wurde nicht gefunden." >&2
            fi
        done

        post_exec() {
            local exec_options=()
            local exec_selected
            for func in "${LOADED_FUNCTIONS[@]}"; do
                exec_options+=("$func" "Führe $func aus" "ON")
            done
            exec_selected=$(whiptail --title "Post-Execution Funktionen" \
              --checklist "Wählen Sie die Funktionen aus, die am Skriptende ausgeführt werden sollen:" \
              20 78 10 "${exec_options[@]}" 3>&1 1>&2 2>&3)
            for func in $exec_selected; do
                func=$(echo "$func" | sed 's/"//g')
                if declare -f "$func" > /dev/null; then
                    "$func"
                else
                    echo "Funktion $func ist nicht definiert." >&2
                fi
            done
        }
        trap post_exec EXIT
    fi

elif [ -n "$FISH_VERSION" ]; then
    # --- Fish-Version ---
    if not set -q GLOBAL_POST_EXEC_INITIALIZED
        set -g GLOBAL_POST_EXEC_INITIALIZED 1

        if not set -q FUNC_DIR
            echo "ERROR: Variable FUNC_DIR ist nicht gesetzt. Bitte setzen Sie FUNC_DIR, bevor Sie fortfahren." >&2
            exit 1
        end

        # Ermitteln aller .sh Dateien in $FUNC_DIR (nur oberste Ebene) und global_post_exec.sh ausschließen
        set func_files
        for file in (ls $FUNC_DIR/*.sh 2>/dev/null)
            if test (basename $file) = "global_post_exec.sh"
                continue
            end
            set func_files $func_files $file
        end

        if test (count $func_files) -eq 0
            echo "Keine Funktionsdateien in \$FUNC_DIR gefunden."
        end

        set options
        for file in $func_files
            set func_name (basename $file .sh)
            set options $options $func_name "Lade $func_name" "ON"
        end

        set selected (whiptail --title "Funktionen laden" --checklist "Wählen Sie die Funktionen, die geladen werden sollen:" 20 78 10 $options 3>&1 1>&2 2>&3)

        set LOADED_FUNCTIONS
        for func in (string split " " $selected)
            set LOADED_FUNCTIONS $LOADED_FUNCTIONS (string trim $func)
        end

        for func in $LOADED_FUNCTIONS
            if test -f "$FUNC_DIR/$func.sh"
                source "$FUNC_DIR/$func.sh"
            else
                echo "WARNUNG: Datei $FUNC_DIR/$func.sh wurde nicht gefunden." >&2
            end
        end

        function post_exec
            set exec_options
            for func in $LOADED_FUNCTIONS
                set exec_options $exec_options $func "Führe $func aus" "ON"
            end

            set exec_selected (whiptail --title "Post-Execution Funktionen" --checklist "Wählen Sie die Funktionen aus, die am Skriptende ausgeführt werden sollen:" 20 78 10 $exec_options 3>&1 1>&2 2>&3)

            for func in (string split " " $exec_selected)
                set func (string trim $func)
                if functions -q $func
                    $func
                else
                    echo "Funktion $func ist nicht definiert." >&2
                end
            end
        end

        trap post_exec EXIT
    end

else
    echo "Unbekannte Shell. Dieses Skript unterstützt nur Bash oder Fish." >&2
    exit 1
fi
