#!/bin/bash
# ssh-key_generieren.sh – Generiert SSH-Schlüssel für ausgewählte Benutzer
# Es erfolgt eine Abfrage, ob der Schlüssel für:
#   1. root
#   2. den aktuell angemeldeten Benutzer (bei sudo: SUDO_USER)
#   3. alle Benutzer (root + alle in /home)
# erstellt werden soll.

read -rp "Für welchen Benutzer sollen SSH-Schlüssel generiert werden? (1) root, (2) angemeldeter Benutzer, (3) alle Benutzer: " choice

case $choice in
  1)
    echo "SSH-Schlüssel für root generieren..."
    mkdir -p /root/.ssh
    if [ ! -f /root/.ssh/id_ed25519 ]; then
      ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -N ""
    else
      echo "SSH-Schlüssel für root existiert bereits."
    fi
    ;;
  2)
    # Bestimme den aktuell angemeldeten Benutzer (bei sudo: SUDO_USER)
    if [ -n "$SUDO_USER" ]; then
       target="$SUDO_USER"
    else
       target="$USER"
    fi
    echo "SSH-Schlüssel für Benutzer $target generieren..."
    user_home=$(getent passwd "$target" | cut -d: -f6)
    mkdir -p "$user_home/.ssh"
    if [ ! -f "$user_home/.ssh/id_ed25519" ]; then
      sudo -u "$target" ssh-keygen -t ed25519 -f "$user_home/.ssh/id_ed25519" -N ""
    else
      echo "SSH-Schlüssel für Benutzer $target existiert bereits."
    fi
    ;;
  3)
    echo "SSH-Schlüssel für alle Benutzer generieren..."
    # Für root:
    mkdir -p /root/.ssh
    if [ ! -f /root/.ssh/id_ed25519 ]; then
      ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -N ""
    else
      echo "SSH-Schlüssel für root existiert bereits."
    fi
    # Für jeden Benutzer im Verzeichnis /home:
    for user_dir in /home/*; do
      if [ -d "$user_dir" ]; then
         user=$(basename "$user_dir")
         echo "SSH-Schlüssel für Benutzer $user generieren..."
         mkdir -p "$user_dir/.ssh"
         if [ ! -f "$user_dir/.ssh/id_ed25519" ]; then
             sudo -u "$user" ssh-keygen -t ed25519 -f "$user_dir/.ssh/id_ed25519" -N ""
         else
             echo "SSH-Schlüssel für Benutzer $user existiert bereits."
         fi
      fi
    done
    ;;
  *)
    echo "Ungültige Auswahl."
    ;;
esac
