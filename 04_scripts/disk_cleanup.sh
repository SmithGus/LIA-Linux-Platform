#!/bin/bash

echo "=== STARTAR DISKRENSNING PÅ LIA-SERVERN ==="

# 1. Rensa APT-cache
echo "[1/8] Rensar APT-cache..."
sudo apt clean

# 2. Ta bort gamla paket och kärnor
echo "[2/8] Tar bort oanvända paket och gamla kärnor..."
sudo apt autoremove --purge -y

# 3. Rensa systemloggar (journalctl äldre än 3 dagar)
echo "[3/8] Rensar journalfiler (behåller senaste 3 dagar)..."
sudo journalctl --vacuum-time=3d

# 4. Töm stora loggfiler manuellt
echo "[4/8] Tömmer syslog och auth.log..."
sudo truncate -s 0 /var/log/syslog
sudo truncate -s 0 /var/log/auth.log

# 5. Rensar Docker-loggar för alla containers (Zabbix, MySQL, Mailhog, Agent, etc.)
echo "[5/8] Rensar Docker containerloggar..."
sudo find /var/lib/docker/containers/ -type f -name "*-json.log" -exec truncate -s 0 {} \;

# 6. Kontroll av diskutrymme efter rensning
echo "[6/8] Diskutrymme efter rensning:"
df -h /

# 7. Starta om rsyslog (om det tidigare haft skrivfel)
echo "[7/8] Startar om rsyslog..."
sudo systemctl restart rsyslog

# 8. Sammanfattning
echo "=== DISKRENSNING KLAR ==="
echo "Om du fortfarande har <500MB ledigt, överväg att utöka disk eller rensa ytterligare loggar/data."
