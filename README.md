# LIA-Linux-Platform
LIA-projekt med DHCP DNS SYSLOG ZABBIX

# LIA: Linuxplattform för nätverkstjänster och övervakning

Detta projekt är en del av en LIA-period och syftar till att bygga och driftsätta en säker Linux-baserad servermiljö. Servern kommer att leverera följande centrala nätverkstjänster:

- DHCP-server (isc-dhcp-server)
- DNS-server (BIND9) med intern zonhantering
- Syslog-server (rsyslog + logrotate)
- Övervakning via Zabbix Server och agent

## Studentinformation

Namn: Gustav Smith  
Utbildning: Nätverkstekniker, TUC Yrkeshögskola  
LIA-period: 6 veckor (heltid)

## Använda tekniker

- Git och GitHub  
- Bash-skript  
- SSH-nyckelautentisering, UFW, fail2ban  
- Operativsystem: Ubuntu Server 22.04.5 LTS (Jammy Jellyfish)
- Virtualiseringsplattform: VMware Workstation Pro 17
- Arkitektur: 64-bit
- Kärnversion: Linux 6.8 (HWE)

## Projektstruktur

- 01_projektplan/
  - projektplan.md
- 02_installation/
  - installationsguide.md
- 03_tjanster/
  - dhcpd.conf
  - named.conf.local
  - zonfiler
- 04_scripts/
  - backup-configs.sh
  - check-services.sh
- 05_zabbix/
  - zabbix-konfig.md
  - template.xml
- 06_test_rapport/
  - slutrapport.docx
  - troubleshooting_log.md
- CHECKLISTA.md
- README.md


## Status

- [x] Projektstart och GitHub klar  
- [ ] Serverinstallation  
- [ ] Tjänstekonfiguration  
- [ ] Automatisering och loggning  
- [ ] Slutrapport och presentation

## Instruktioner

Detta avsnitt kommer att uppdateras med information om hur projektet installeras, startas och testas.

## Licens

Fritt att använda i utbildningssyfte.
