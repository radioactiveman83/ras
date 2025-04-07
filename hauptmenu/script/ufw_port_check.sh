#!/bin/bash

# Anzeigen einer Nachricht zum Start des Prozesses
echo "Erstelle Skript zur Überprüfung der UFW-Freigaben (/usr/local/bin/check_ufw_ports.sh)"

# Skript zur Überprüfung der UFW-Freigaben erstellen
cat <<'EOF' | sudo tee /usr/local/bin/check_ufw_ports.sh >/dev/null
#!/bin/bash
# Dieses Skript überprüft, ob alle benötigten Ports freigegeben sind.
REQUIRED_PORTS=(21 80 443 4200 8181 3307 8080 8082 8083 8084 9001 19999 3000 3001 3002 3003 30000 30001 30002 30003 30004 30005 30006 30007 30008 30009 8085 9000 7912)
echo "Überprüfe UFW-Freigaben für benötigte Ports..."
for port in "\${REQUIRED_PORTS[@]}"; do
    if ! ufw status | grep -q "\${port}/tcp"; then
        echo "Port \${port}/tcp nicht freigegeben – erlaube..."
        ufw allow "\${port}/tcp"
    else
        echo "Port \${port}/tcp ist bereits freigegeben."
    fi
done
echo "UFW-Portprüfung abgeschlossen."
EOF

# Skript ausführbar machen
sudo chmod +x /usr/local/bin/check_ufw_ports.sh

# Feedback geben, dass das Skript erstellt wurde
echo "Das Skript check_ufw_ports.sh wurde erstellt und ist bereit zur Ausführung."
