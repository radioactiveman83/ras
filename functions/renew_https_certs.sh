#!/bin/bash
# renew_https_certs.sh – Skript zur Erneuerung von HTTPS-Zertifikaten mit Certbot

# Prüfen, ob das Skript als Root ausgeführt wird
if [ "$(id -u)" -ne 0 ]; then
    echo "Dieses Skript muss als Root oder mit sudo ausgeführt werden."
    exit 1
fi

# Eine einfache Funktion zur Ausgabe von Nachrichten
announce() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Funktion zum Erneuern der Zertifikate
renew_certs() {
    announce "Beginne mit der Erneuerung der HTTPS-Zertifikate..."

    # Certbot zur Erneuerung der Zertifikate nutzen
    certbot renew --quiet

    # Prüfen, ob der Renewal-Prozess erfolgreich war
    if [ $? -eq 0 ]; then
        announce "Zertifikate wurden erfolgreich erneuert."
        # Optional: Dienste neu starten, die das Zertifikat verwenden
        systemctl restart apache2
        systemctl restart nginx
        announce "Webserver wurden neu gestartet."
    else
        announce "Fehler beim Erneuern der Zertifikate."
        exit 1
    fi
}

# Hauptausführungsfunktion
renew_certs

