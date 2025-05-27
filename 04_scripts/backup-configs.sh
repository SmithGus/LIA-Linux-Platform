#!/bin/bash
# backup-configs.sh – säkerhetskopierar konfigfiler
# Körs via cron varje natt kl 02:00
# Cronrad: 0 2 * * * /home/localadmin/LIA-Linux-Platform/04_scripts/backup-configs.sh >> /var/log/backup-configs.log 2>&1



#!/bin/bash
#backup-configs.sh
# enkel säkerhetskopiering av viktiga konfigfiler

#Måste köras som root
if [ "$EUID" -ne 0 ]; then
  echo "kör som root!" >&2
  exit 1
fi


BACKUP_DIR="/var/backups/configs-$(date +%Y%m%d_%H%M%S)"
FILES=(
    /etc/rsyslog.conf
    /etc/rsyslog.d/
    /etc/logrotate.d/
    /etc/netplan/
    /etc/resolv.conf
    /etc/systemd/resolved.conf
    /etc/hosts
    /etc/hostname
    /etc/bind/
    /home/localadmin/LIA-Linux-Platform/
    
)

mkdir -p "$BACKUP_DIR"



if [ ! -d "$BACKUP_DIR" ]; then
    echo "Kunde inte skapa backupmapp" >&2
    logger "[backup-configs] FEL: Kunde inte skapa $BACKUP_DIR"
    exit 1
fi


for FILE in "${FILES[@]}"; do
  if [ -e "$FILE" ]; then
    cp -a "$FILE" "$BACKUP_DIR" 2>/dev/null
  else
    echo "Varning Saknas: $FILE"
    logger "[backup-configs] VARNING: Saknas $FILE"
  fi
done

COUNT=$(find "$BACKUP_DIR" -type f | wc -l)


echo "Backup klar: $BACKUP_DIR ($COUNT filer)"
logger "[backup-configs] Backup klar: $BACKUP_DIR ($COUNT filer)"
