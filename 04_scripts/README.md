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



## backup-bind-slave.sh

Detta script säkerhetskopierar viktiga BIND9-konfigurationsfiler på **LIA-slave**-servern. Eftersom denna DNS-slavserver synkroniserar zonfiler från en DNS-master är det oftast inte nödvändigt att inkludera zonfiler – men det kan vara bra att dokumentera och spara konfigurationen lokalt för kontroll, felsökning eller historik.

### Funktion
- Skapar en backupkatalog baserat på datum och tid.
- Kopierar följande:
  - `/etc/bind/`
  - `/etc/hostname`
  - `/etc/resolv.conf`
  - `/etc/systemd/resolved.conf`

### Exempel

```bash
$ sudo ./backup-bind-slave.sh
Backup klar: /var/backups/bind-slave-20250527_095950
```

Lagringsplats

Alla backupfiler sparas under:

/var/backups/bind-slave-YYYYMMDD_HHMMSS/
