#!/bin/bash
echo "Generiere Deinstallationsliste..."
INSTALLED_PKGS=$(dpkg --get-selections | grep -v deinstall | awk '{{print $1}}')
OPTIONS=()
for pkg in $INSTALLED_PKGS; do
    OPTIONS+=("$pkg" "Deinstalliere $pkg" OFF)
done

whiptail --title "Paketdeinstallation" --checklist \
"Bitte wähle zu deinstallierende Pakete:" 20 78 10 \
"${{OPTIONS[@]}}" 2>results

while read -r pkg; do
    apt remove -y $pkg
done < results
rm results