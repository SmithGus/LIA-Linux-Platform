#!/bin/bash
# check-services.sh – kontrollerar tjänststatus och loggar till syslog
# Körs via cron varje hel timme
# Cronrad: 0 * * * * /home/localadmin/LIA-Linux-Platform/04_scripts/check-services.sh >> /var/log/check-services.log 2>&1



#!/bin/bash
# check-services.sh
# Enkel kontroll av viktiga tjänster med loggning till syslog

SERVICES=("rsyslog" "named" "ufw" "zabbix-agent")

for SERVICE in "${SERVICES[@]}"; do
    systemctl is-active --quiet "$SERVICE"
    if [ $? -eq 0 ]; then
        logger "[check-services] OK: $SERVICE är aktivt"
    else
        logger "[check-services] FEL: $SERVICE är INTE aktivt"
    fi
done
