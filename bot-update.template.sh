# Bitte ersetze die Platzhalter SSID und PASSWORD durch die tatsächlichen WLAN-Verbindungsdaten und passe die Befehle zum Aktualisieren des GitHub-Repositorys entsprechend an.

#!/bin/bash

# Skript muss als Root ausgeführt werden
if [ "$(id -u)" != "0" ]; then
  echo "Dieses Skript muss als Root ausgeführt werden." >&2
  exit 1
fi

# Überprüfen, ob benötigte Programme installiert sind
command -v iwconfig >/dev/null 2>&1 || { echo "iwconfig ist nicht installiert. Installation wird abgebrochen." >&2; exit 1; }
command -v git >/dev/null 2>&1 || { echo "git ist nicht installiert. Installation wird abgebrochen." >&2; exit 1; }
command -v apt >/dev/null 2>&1 || { echo "apt ist nicht installiert. Installation wird abgebrochen." >&2; exit 1; }

# WLAN mit Netzwerk verbinden
iwconfig wlan0 essid DeinNetzwerkName key Passwort
until ping -c1 www.google.com &>/dev/null; do
  echo "Warte auf die WLAN-Verbindung..."
  sleep 1
done
echo "Mit dem WLAN verbunden."

# GitHub Repository und Branch überprüfen
REPO_PATH="/home/bot-1/freqtrade"
BRANCH="main"

if [ -d "$REPO_PATH/.git" ]; then
  cd "$REPO_PATH"
  # Überprüfen, ob die richtige Branch verwendet wird
  if [ "$(git rev-parse --abbrev-ref HEAD)" != "$BRANCH" ]; then
    echo "Nicht auf der Branch '$BRANCH'. Wechsel zu dieser Branch."
    git checkout $BRANCH
  fi
  # Repository aktualisieren
  git pull
  echo "Repository aktualisiert."
else
  echo "Das angegebene Verzeichnis '$REPO_PATH' ist kein Git-Repository. Überprüfen Sie den Pfad oder klone das Repository."
  # Optional: Git Repository klonen, wenn nicht vorhanden
  # git clone <Repository-URL> "$REPO_PATH"
  # cd "$REPO_PATH"
  # git checkout $BRANCH
fi

# System-Updates durchführen
apt update && apt upgrade -y
echo "System aktualisiert."

# Füge das Skript dem Startup hinzu, indem du es z.B. in /etc/rc.local einfügst
echo "Skriptkonfiguration abgeschlossen."

