## Automatiseringsscript 

Följande scripts finns i `04_scripts/`för att automatisera säkerhetsinställningar:

- `setuo_ufw.sh` - Aktiverar UFW-brandväggen, tillåter SSH, HTTP, HTTPS och Zabbix-portar.
- `setup_fail2ban.sh` - Installerar och konfiguerar Fail2ban med grundläggande skydd för SSH.

Dessa scripts för det möjligt att snabbt återställa säkerhetsinställningar vid behov. 



## backup-configs.sh

Det här skriptet skapar en tidsstämplad säkerhetskopia av viktiga konfigurationsfiler och mappar.

### Funktioner:
- Skapar backupkatalog under `/var/backups/` med namn: `configs-YYYYMMDD_HHMMSS`
- Kopierar systemfiler som rör:
  - Syslog (rsyslog)
  - Logghantering (logrotate)
  - Nätverk (netplan)
  - DNS-konfiguration (bind, resolv.conf)
  - Värdnamn och värdfil
  - Dokumentationsprojektet (GitHub-repot)
- Skriver loggrad bekräftelse till `syslog`

### Filinnehåll:
```bash
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
```
Exekvering:

sudo ./backup-configs.sh

Om backupkatalogen inte kan skapas loggas ett felmeddelande. Saknade filer flaggas som varningar.
Exempel på loggrad i syslog:

[backup-configs] Backup klar: /var/backups/configs-20250527_103212 (23 
