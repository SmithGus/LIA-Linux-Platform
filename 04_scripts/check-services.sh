#!/bin/bash
# check-services.sh
# Enkel kontroll av viktiga tjänster med loggning till syslog

logger "[check-services] START: kontroll av tjänster"

SERVICES=("rsyslog" "named" "ufw" "isc-dhcp-server" "chrony")

for SERVICE in "${SERVICES[@]}"; do
    systemctl is-active --quiet "$SERVICE"
    if [ $? -eq 0 ]; then
        logger "[check-services] OK: $SERVICE är aktivt"
    else
        logger "[check-services] FEL: $SERVICE är INTE aktivt"
    fi
done

logger "[check-services] SLUT: Kontroll av tjänster klar"
