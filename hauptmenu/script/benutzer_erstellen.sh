#!/bin/bash
# benutzer_erstellen.sh – Skript zur Erstellung eines Benutzers und Hinzufügen zur sudo-Gruppe
# Dieses Skript fragt den gewünschten Benutzernamen, das Passwort und die E-Mail-Adresse ab, legt den Benutzer (falls noch nicht vorhanden)
# mit der fish-Shell als Standard fest, setzt das Passwort, fügt den Benutzer der sudo-Gruppe hinzu und erstellt
# einen sudoers-Eintrag, der die Ausführung von sudo ohne Passwort ermöglicht.
# Anschließend wird das Skript in das Home-Verzeichnis des neuen Benutzers kopiert, falls es dort noch nicht existiert.

# Prüfen, ob das Skript als Root ausgeführt wird
if [ "$(id -u)" -ne 0 ]; then
    echo "Bitte führe das Skript als Root oder mit sudo aus."
    exit 1
fi

# Versuche, die announce-Funktion zu laden (aus $FUNC_DIR/announce.sh), ansonsten eine einfache Version definieren
if [ -n "$FUNC_DIR" ] && [ -f "$FUNC_DIR/announce.sh" ]; then
    source "$FUNC_DIR/announce.sh"
else
    announce() {
        echo "$1"
    }
fi

# Benutzereingaben abfragen
read -rp "Bitte geben Sie den Benutzernamen ein: " USERNAME
read -srp "Bitte geben Sie das Passwort für $USERNAME ein: " USER_PASSWORD
echo
read -rp "Bitte geben Sie die E-Mail-Adresse für $USERNAME ein: " USER_EMAIL
echo

# Name des Skripts (zur Selbstkopie)
SCRIPTNAME=$(basename "$0")

announce "Benutzerkonfiguration"

# Benutzer anlegen, falls nicht vorhanden, und dabei fish als Standardshell setzen
if ! id -u "$USERNAME" >/dev/null 2>&1; then
    useradd -m -s /usr/bin/fish "$USERNAME"
    echo "$USERNAME:$USER_PASSWORD" | chpasswd  # Passwort setzen
    usermod -aG sudo "$USERNAME"  # Benutzer zur sudo-Gruppe hinzufügen
fi

# Erstelle einen sudoers-Eintrag, der dem Benutzer sudo ohne Passwort ermöglicht
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/"$USERNAME"
chmod 440 /etc/sudoers.d/"$USERNAME"

# Speichern der E-Mail-Adresse des Benutzers in einer Datei im Home-Verzeichnis
echo "$USER_EMAIL" > "/home/$USERNAME/user_email.txt"
chown "$USERNAME:$USERNAME" "/home/$USERNAME/user_email.txt"

# Selbstkopie: Kopiere dieses Skript in das Home-Verzeichnis des neuen Benutzers, falls es noch nicht dort liegt
TARGET="/home/$USERNAME/$SCRIPTNAME"
if [[ "$(realpath "$0")" != "$TARGET" ]]; then
    cp "$0" "$TARGET"
    chown "$USERNAME:$USERNAME" "$TARGET"
    chmod +x "$TARGET"
fi

announce "Benutzer $USERNAME wurde erstellt und zur sudo-Gruppe hinzugefügt. E-Mail-Adresse wurde gespeichert."
