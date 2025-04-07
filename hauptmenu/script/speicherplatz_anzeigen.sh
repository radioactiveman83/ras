#!/bin/bash
# speicherplatz_anzeigen.sh – Zeigt den gesamten und den belegten Speicherplatz der Systempartition (/) an

echo "Speicherplatz der Systempartition (/):"
df -h / | awk 'NR==2 {print "Gesamter Speicherplatz: " $2 ", Belegter Speicherplatz: " $3}'
