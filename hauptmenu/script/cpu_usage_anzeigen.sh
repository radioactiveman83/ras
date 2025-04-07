#!/bin/bash
# cpu_usage_anzeigen.sh – Zeigt die aktuelle, durchschnittliche und maximale CPU-Auslastung an
# Es werden über 5 Sekunden pro Sekunde Messungen durchgeführt.

samples=5
interval=1

total_usage=0
max_usage=0

echo "Messe CPU-Auslastung..."

for i in $(seq 1 $samples); do
    # Verwende den zweiten Durchlauf von top für genauere Werte
    usage=$(top -bn2 | grep "Cpu(s)" | tail -n 1 | awk '{print $2 + $4}')
    # Berechnung in bc durchführen
    usage_val=$(echo "$usage" | bc)
    total_usage=$(echo "$total_usage + $usage_val" | bc)
    if (( $(echo "$usage_val > $max_usage" | bc -l) )); then
        max_usage=$usage_val
    fi
    sleep $interval
done

avg_usage=$(echo "scale=2; $total_usage / $samples" | bc)
current_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

echo "Aktuelle CPU-Auslastung: $current_usage %"
echo "Durchschnittliche CPU-Auslastung (über $samples Sekunden): $avg_usage %"
echo "Maximale CPU-Auslastung (über $samples Sekunden): $max_usage %"
