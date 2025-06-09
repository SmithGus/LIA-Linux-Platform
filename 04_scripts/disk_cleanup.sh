#!/bin/bash

# Datum och tid
echo "=== Diskrensning startad: $(date) ==="

# Mäta utrymme före
BEFORE=$(df -h / | awk 'NR==2 {print $5}')

echo "[1/9] Utrymme före rensning: $BEFORE använt"

# 1. Rensa APT-cache
echo "[2/9] Rensar APT-cache..."
sudo apt clean

# 2. Ta bort gamla paket och kärnor
echo "[3/9] Tar bort oanvända paket och gamla kärnor..."
sudo apt autoremove --purge -y

# 3. Rensa journalfiler
echo "[4/9] Rensar journalfiler (behåller 3 dagar)..."
sudo journalctl --vacuum-time=3d

# 4. Tömma stora systemloggar
echo "[5/9] Tömmer syslog och auth.log..."
sudo truncate -s 0 /var/log/syslog
sudo truncate -s 0 /var/log/auth.log

# 5. Rensa Docker-loggar (alla containrar)
echo "[6/9] Rensar Docker containerloggar..."
sudo find /var/lib/docker/containers/ -type f -name "*-json.log" -exec truncate -s 0 {} \;

# 6. Visa utrymme efter
AFTER=$(df -h / | awk 'NR==2 {print $5}')
echo "[7/9] Utrymme efter rensning: $AFTER använt"

# 7. Starta om rsyslog
echo "[8/9] Startar om rsyslog..."
sudo systemctl restart rsyslog

# 8. Klar
echo "[9/9] Rensning färdig. Utrymme före: $BEFORE | efter: $AFTER"
echo "=== Diskrensning klar: $(date) ==="
echo ""

logger "CRON: disk_cleanup.sh kördes via cron - $(date)"
