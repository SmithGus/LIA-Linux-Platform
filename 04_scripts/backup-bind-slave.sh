#!/bin/bash
# backup-bind-slave.sh – enkel backup av konfigfiler för DNS-slave

BACKUP_DIR="/var/backups/bind-slave-$(date +%Y%m%d_%H%M%S)"
FILES=(
    /etc/bind/named.conf
    /etc/bind/named.conf.options
    /etc/bind/named.conf.local
    /etc/bind/named.conf.default-zones
)

mkdir -p "$BACKUP_DIR"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Kunde inte skapa backupmapp" >&2
    logger "[backup-bind-slave] FEL: Kunde inte skapa $BACKUP_DIR"
    exit 1
fi

for FILE in "${FILES[@]}"; do
    if [ -e "$FILE" ]; then
        cp -a "$FILE" "$BACKUP_DIR" 2>/dev/null
    else
        echo "Varning: Saknas: $FILE"
        logger "[backup-bind-slave] VARNING: Saknas $FILE"
    fi
done

COUNT=$(find "$BACKUP_DIR" -type f | wc -l)
echo "Backup klar: $BACKUP_DIR ($COUNT filer)"
logger "[backup-bind-slave] Backup klar: $BACKUP_DIR ($COUNT filer)"
