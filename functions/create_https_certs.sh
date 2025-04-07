#!/bin/bash
# create_https_certs.sh - Skript zum Registrieren eines ACME-Accounts und Beziehen von Zertifikaten für Domains,
# einschließlich Handhabung von Portkonflikten auf Port 80, auch für Docker-Container.

# Funktion, um die Ausführung als Root zu überprüfen
ensure_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Das Skript muss als Root ausgeführt werden."
        exit 1
    fi
}

# Funktion, um zu prüfen, ob Port 80 belegt ist und ggf. den belegenden Prozess zu stoppen
check_and_stop_service() {
    # Port 80 prüfen
    if lsof -i :80 | grep LISTEN; then
        echo "Port 80 ist belegt. Versuche, den Dienst zu stoppen..."
        local process_name=$(lsof -i :80 | grep LISTEN | awk '{print $1}' | head -1)
        local process_id=$(lsof -i :80 | grep LISTEN | awk '{print $2}' | head -1)

        # Überprüfe, ob der Prozess zu einem Docker-Container gehört
        if [[ "$process_name" == "docker-proxy" ]]; then
            local container_id=$(docker ps --filter "publish=80" --format "{{.ID}}")
            echo "Docker-Container $container_id auf Port 80 gefunden. Pausiere den Container..."
            docker pause $container_id
            echo $container_id > /tmp/paused_docker_container.txt
        elif systemctl is-active --quiet "$process_name"; then
            echo "Stoppe den Service $process_name..."
            systemctl stop "$process_name"
            echo "$process_name" > /tmp/stopped_service.txt  # Speichern des Dienstnamens für den Neustart
        else
            echo "Der Prozess $process_name kann nicht gestoppt werden. Überprüfen Sie die Konfiguration manuell."
            exit 1
        fi
    else
        echo "Port 80 ist frei."
    fi
}

# Funktion, um den vorher gestoppten Dienst oder Docker-Container neu zu starten
restart_service_or_container() {
    if [ -f /tmp/paused_docker_container.txt ]; then
        local container_id=$(cat /tmp/paused_docker_container.txt)
        echo "Starte den Docker-Container $container_id neu..."
        docker unpause $container_id
        rm /tmp/paused_docker_container.txt
    elif [ -f /tmp/stopped_service.txt ]; then
        local service_name=$(cat /tmp/stopped_service.txt)
        echo "Starte den Service $service_name neu..."
        systemctl start "$service_name"
        rm /tmp/stopped_service.txt
    fi
}

# Funktion, um Certbot für die Registrierung und Zertifikatserstellung zu nutzen
create_certs() {
    local email=$1
    local domains=$2

    # ACME-Account registrieren
    echo "Registriere ACME-Account für $email..."
    certbot register --agree-tos --email "$email"

    # Zertifikate für die angegebenen Domains beziehen
    echo "Beziehe Zertifikate für Domains: $domains..."
    certbot certonly --standalone --preferred-challenges http -d $domains
}

# Hauptausführungsteil des Skripts
main() {
    ensure_root

    # Eingabeaufforderungen für Benutzer
    read -rp "Bitte geben Sie die E-Mail-Adresse für die ACME-Registrierung ein: " user_email
    read -rp "Bitte geben Sie die Domains ein, getrennt durch Kommata (z.B. example.com,www.example.com): " domain_list

    # Domains für Certbot-Befehl vorbereiten
    formatted_domains=$(echo $domain_list | sed "s/,/ -d /g")

    # Portprüfung und Dienst/Container stoppen, falls notwendig
    check_and_stop_service

    # Zertifikate erstellen
    create_certs "$user_email" "$formatted_domains"

    # Gestoppten Dienst/Container neu starten
    restart_service_or_container
}

# Skript ausführen
main
