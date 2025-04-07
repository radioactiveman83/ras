#!/bin/bash
# fish-shell_config.sh - Skript zur Einrichtung einer benutzerspezifischen Fish-Shell-Konfiguration

# Funktion, um Mitteilungen anzuzeigen
announce() {
    echo "$1"
}

# Prüfen, ob das Skript als Root ausgeführt wird
if [ "$(id -u)" -ne 0 ]; then
    echo "Bitte führe das Skript als Root oder mit sudo aus."
    exit 1
fi

# Überprüfen, ob USERNAME gesetzt ist
if [ -z "$USERNAME" ]; then
    echo "USERNAME Umgebungsvariable ist nicht gesetzt. Bitte setzen Sie diese und führen Sie das Skript erneut aus."
    exit 1
fi

# Erstellung der Fish-Shell-Konfiguration
announce "Erstelle Fish-Shell-Konfiguration (falls nicht vorhanden)"
if [ ! -f /home/$USERNAME/.config/fish/config.fish ]; then
    sudo -u "$USERNAME" mkdir -p /home/$USERNAME/.config/fish
    cat <<'EOF' | sudo -u "$USERNAME" tee /home/$USERNAME/.config/fish/config.fish >/dev/null
# Fish Shell Konfiguration: hishtory, nützliche Aliase und tmux-Hilfe
hashtory init --shell fish | source
alias dc="docker compose"
alias dps="docker ps"
alias dlogs="docker compose logs"
alias tmux_help='echo "tmux Anleitung:
- Ctrl+b + Pfeiltasten: Wechseln zu einem bestimmten Pane
- Ctrl+b o: Zyklischer Wechsel zwischen Panes
- Ctrl+b ;: Zum zuletzt aktiven Pane zurückkehren"'
EOF
    announce "Fish-Shell-Konfiguration wurde erstellt."
else
    announce "Fish-Shell-Konfiguration existiert bereits – überspringe."
fi
