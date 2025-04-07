#!/bin/bash
# ram_usage_anzeigen.sh – Zeigt den gesamten und den belegten RAM des Systems an

echo "RAM-Auslastung:"
free -h | awk '/^Mem:/ {print "Gesamter RAM: " $2 ", Belegter RAM: " $3}'
