Bitte ersetze die Platzhalter SSID und PASSWORD durch die tatsächlichen WLAN-Verbindungsdaten und passe die Befehle zum Aktualisieren des GitHub-Repositorys entsprechend an.

#!/bin/bash
# Bot Update Script

# Funktion zum Verbinden mit dem WLAN
verbinde_wlan() {
    echo "Schritt 1: Verbinde mit WLAN..."
    if nmcli device wifi connect SSID password PASSWORD; then
        echo "Erfolgreich mit WLAN verbunden."
    else
        echo "Fehler: Verbindung mit WLAN fehlgeschlagen."
        exit 1
    fi
}

# Funktion zum Aktualisieren des GitHub-Repositorys
update_repo() {
    echo "Schritt 2: Aktualisiere GitHub-Repository..."
    cd /home/bot-1/freqtrade/ || { echo "Fehler: Verzeichnis nicht gefunden."; exit 1; }
    if git pull origin master; then
        echo "GitHub-Repository erfolgreich aktualisiert."
    else
        echo "Fehler: Aktualisierung des GitHub-Repositorys fehlgeschlagen."
        exit 1
    fi
}

# Funktion zum Aktualisieren des Linux-Systems
update_system() {
    echo "Schritt 3: Aktualisiere Linux-System..."
    if sudo apt update && sudo apt upgrade -y; then
        echo "Linux-System erfolgreich aktualisiert."
    else
        echo "Fehler: Aktualisierung des Linux-Systems fehlgeschlagen."
        exit 1
    fi
}

# Hauptfunktion, die alle Funktionen aufruft
main() {
    verbinde_wlan
    update_repo
    update_system
    echo "Skript ausgeführt und Updates durchgeführt."
}

# Aufruf der Hauptfunktion
main

exit 0
