#!/bin/bash
echo "Generiere Installationsliste..."
cd /hauptmenu/script/apt_install
OPTIONS=()
for script in *.sh; do
    pkg=${{script%_installieren.sh}}
    if dpkg -s $pkg &>/dev/null; then
        OPTIONS+=("$script" "$pkg ist bereits installiert" OFF)
    else
        OPTIONS+=("$script" "Installiere $pkg" ON)
    fi
done

whiptail --title "Paketinstallation" --checklist \
"Bitte wähle zu installierende Pakete:" 20 78 10 \
"${{OPTIONS[@]}}" 2>results

while read -r line; do
    . "/hauptmenu/script/apt_install/$line"
done < results
rm results