#!/bin/bash
export RAS_HOME=$(pwd)
# Prüfen, ob das Skript als Root ausgeführt wird
if [ "$(id -u)" -ne 0 ]; then
    echo "Bitte führe das Skript als Root oder mit sudo aus."
    exit 1
fi
# Installation von dos2unix, falls nicht bereits installiert
if ! command -v dos2unix &>/dev/null; then
    echo "Installiere dos2unix..."
    apt-get update && apt-get install -y dos2unix
fi

# Wurzelverzeichnis, von dem aus alle Dateien konvertiert werden sollen
root_directory="$RAS_HOME/"

# Anwenden von dos2unix auf jede Datei rekursiv
find "$root_directory" -type f -exec dos2unix {} + 

echo "Alle Dateien wurden erfolgreich konvertiert."

chmod +x $RAS_HOME/functions/execute_scripts.sh
##############################
# 1. Systemupdate & Bereinigung
##############################
apt update -y
apt upgrade -y
apt autoremove -y
apt clean -y
$RAS_HOME/functions/execute_scripts.sh
MENU_DIR="hauptmenu"
##############################
# 2. Systemerweiterung und Installation
##############################

# 2a. System für systemctl (Services) erweitern
if ! command -v systemctl &>/dev/null; then
    echo "systemctl nicht gefunden. Versuche, systemd zu installieren..."
    $RAS_HOME/hauptmenu/script/apt_install/systemd_installieren.sh
fi

# 2b. Installation der nötigen Pakete
$RAS_HOME/hauptmenu/script/apt_install/git_installieren.sh
$RAS_HOME/hauptmenu/script/apt_install/curl_installieren.sh
$RAS_HOME/hauptmenu/script/apt_install/wget_installieren.sh
$RAS_HOME/hauptmenu/script/apt_install/apt-transport-https_installieren.sh
$RAS_HOME/hauptmenu/script/apt_install/sudo_installieren.sh
$RAS_HOME/hauptmenu/script/apt_install/bash_installieren.sh
$RAS_HOME/hauptmenu/script/apt_install/python3_installieren.sh
$RAS_HOME/hauptmenu/script/apt_install/unzip_installieren.sh

# 2c. hishtory-server installieren und starten
$RAS_HOME/hauptmenu/script/apt_install/hishtory-server_installieren.sh

##############################
# 3. Installation und Vorbereitung von whiptail
##############################
apt install -y whiptail

##############################
# 4. Erstellung der Hauptmenü-Ordner und weiterer Verzeichnisse
##############################
MENU_DIR="hauptmenu"
mkdir -p $RAS_HOME/"$MENU_DIR"
mkdir -p $RAS_HOME/"$MENU_DIR/inactive"  # Ordner für inaktive (auskommentierte) Menüpunkte

# Zusätzliche Verzeichnisse für Variablen, Dokumente, Dateien, Funktionen, Libraries und Logs
VAR_DIR="variables"
mkdir -p $RAS_HOME/"$VAR_DIR"
DOCS_DIR="docs"
mkdir -p $RAS_HOME/"$DOCS_DIR"
FILES_DIR="files"
mkdir -p $RAS_HOME/"$FILES_DIR"
FUNC_DIR="functions"
mkdir -p $RAS_HOME/"$FUNC_DIR"
LIB_DIR="libaries"
mkdir -p $RAS_HOME/"$LIB_DIR"
LOG_DIR="logs"
mkdir -p $RAS_HOME/"$LOG_DIR"
readonly SLEEP_TIME=5

# Quelle der Funktion zum Exportieren der Variablen (s. export_variables.sh)
source $RAS_HOME/functions/export_variables.sh
export_all_variables

##############################
# 5. Erstellung der hauptmenu.txt (ohne Nummerierung)
##############################
cat <<'EOF' > $RAS_HOME/"$MENU_DIR/hauptmenu.txt"
Info [info]
Einstellungen & Konfiguration [setup]
Aktualisierungen [update]
(De-)Installationen [install]
Starten & Stoppen [start]
Anpassungen [config]
Sicherheit [security]
Prüfungen [checks]
Monitoring [monitoring]
Scripte [script]
EOF

##############################
# 6. Erstellung der Unterordner und initialen .txt Dateien
##############################
while IFS= read -r line || [ -n "$line" ]; do
    # Überspringe leere Zeilen
    if [[ -z "$line" ]]; then
        continue
    fi

    # Prüfe, ob die Zeile auskommentiert ist (beginnt mit '#')
    if [[ "$line" =~ ^[[:space:]]*# ]]; then
        # Entferne das Kommentarzeichen, um den Ordnernamen zu extrahieren
        uncommented_line=$(echo "$line" | sed 's/^[[:space:]]*#//')
        folder=$(echo "$uncommented_line" | grep -oP '\[\K[^\]]+')
        # Stelle sicher, dass die Zeile wieder auskommentiert wird (in der Variablen)
        line="#${uncommented_line}"
        # Erstelle bzw. sichere den Unterordner im "inactive"-Verzeichnis
        mkdir -p $RAS_HOME/"$MENU_DIR/inactive/$folder"
        # Erstelle die .txt-Datei nur, falls sie noch nicht existiert
        if [ ! -f $RAS_HOME/"$MENU_DIR/inactive/$folder/$folder.txt" ]; then
            mkdir -p $RAS_HOME/"$MENU_DIR/inactive/$folder"
            touch $RAS_HOME/"$MENU_DIR/inactive/$folder/$folder.txt"
        fi
    else
        folder=$(echo "$line" | grep -oP '\[\K[^\]]+')
        # Prüfe, ob der Ordner bereits im Inactive-Verzeichnis existiert und verschiebe ihn
        if [ -d $RAS_HOME/"$MENU_DIR/inactive/$folder" ]; then
            mv "$MENU_DIR/inactive/$folder" "$MENU_DIR/"
        fi
        mkdir -p $RAS_HOME/"$MENU_DIR/$folder"
        if [ ! -f $RAS_HOME/"$MENU_DIR/$folder/$folder.txt" ]; then
            touch $RAS_HOME/"$MENU_DIR/$folder/$folder.txt"
        fi
    fi
done < "$MENU_DIR/hauptmenu.txt"

##############################
# 7. Rechte für sudo-Benutzer setzen
##############################
# Gruppeneigentümer aller erstellten Dateien und Ordner auf "sudo" setzen
chown -R root:sudo $RAS_HOME/"$MENU_DIR" $RAS_HOME/"$VAR_DIR" $RAS_HOME/"$DOCS_DIR" $RAS_HOME/"$FILES_DIR" $RAS_HOME/"$FUNC_DIR" $RAS_HOME/"$LIB_DIR" $RAS_HOME/"$LOG_DIR"
# Für alle Verzeichnisse: 2775 (Lesen, Schreiben, Ausführen; neue Dateien erben Gruppen-ID)
find $RAS_HOME/"$MENU_DIR" $RAS_HOME/"$VAR_DIR" $RAS_HOME/"$DOCS_DIR" $RAS_HOME/"$FILES_DIR" $RAS_HOME/"$FUNC_DIR" $RAS_HOME/"$LIB_DIR" $RAS_HOME/"$LOG_DIR" -type d -exec chmod 2775 {} \;
# Für alle Dateien: 664 (Lesen, Schreiben für Besitzer und Gruppe; Lesen für Andere)
find $RAS_HOME/"$MENU_DIR" $RAS_HOME/"$VAR_DIR" $RAS_HOME/"$DOCS_DIR" $RAS_HOME/"$FILES_DIR" $RAS_HOME/"$FUNC_DIR" $RAS_HOME/"$LIB_DIR" $RAS_HOME/"$LOG_DIR" -type f -exec chmod 664 {} \;

##############################
# 8. Aufruf des interaktiven Menüs (menu.sh)
##############################
# Das interaktive Menü befindet sich in $RAS_HOME/hauptmenu/menu.sh
if [ -x $RAS_HOME/"$MENU_DIR/menu.sh" ]; then
    $RAS_HOME/"$MENU_DIR/menu.sh"
else
    bash $RAS_HOME/"$MENU_DIR/menu.sh"
fi

exit 0
