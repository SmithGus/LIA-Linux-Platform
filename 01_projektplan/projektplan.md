# Projektplan – LIA: Linuxplattform

**Student:** Gustav Smith  
**Utbildning:** Nätverkstekniker, TUC  
**LIA-period:** 6 veckor (april–juni 2025)  

---

##  Syfte

Att bygga och driftsätta en säker och automatiserad Linuxbaserad servermiljö för centrala nätverkstjänster, övervakning och logghantering i en isolerad labbmiljö.

---

##  Mål

- Ubuntu Server LTS (22.04) installation i VMware
- Tidsserver med Chrony (NTP)
- DHCP-server (isc-dhcp-server)
- DNS-server (BIND9) med redundans (master/slave)
- Syslog + logrotate för central logghantering
- Zabbix Server + Agent för övervakning
- Automatiseringsskript: backup, statuskontroll, rensning
- Säkerhetshärdning: SSH-nycklar, UFW, fail2ban, least privilege
- Dokumentation och versionering i GitHub

---

##  Tidsplan & Leverabler

| Vecka | Delmoment                                      | Leverabler                          |
|-------|------------------------------------------------|-------------------------------------|
| V1    | Projektplan, installation av servermiljö       | Projektplan.md, systemstatus        |
| V2    | Härdning, SSH, brandvägg, Chrony               | chrony.conf, ufw.conf, sshd_config |
| V3    | DHCP & DNS (inkl. zonfiler + slavserver)       | dhcpd.conf, named.conf, zonfiler    |
| V4    | Syslog + logrotate, test + verifiering         | rsyslog.conf, logrotate.d/          |
| V5    | Zabbix (Docker & vanlig), notifieringar        | zabbix_server.conf, screenshots     |
| V6    | Sluttest, skript, rapport, push till GitHub    | Slutrapport.md, bash-skript         |

---

##  Risker & Åtgärder

| Risk                                | Åtgärd                                      |
|-------------------------------------|---------------------------------------------|
| Felkonfigurerade tjänster           | Testrutiner, valideringskommandon           |
| Minnesproblem (Zabbix Docker)       | Gick över till host-installation            |
| DNS/DHCP-strul                      | Manuella zonvalideringar och loggranskning  |
| Felsökning av notifieringar         | Verifiering med `logger`, mailtest          |
| Manuell dokumentation               | Automatiserad backup + Git-versionshantering|

---

##  Verktyg & Tekniker

- **OS:** Ubuntu Server 22.04.5 LTS (VMware)
- **Tjänster:** Chrony, isc-dhcp-server, BIND9, rsyslog, logrotate, Zabbix
- **Säkerhet:** UFW, fail2ban, SSH-nycklar, minsta privilegier
- **Automation:** Bash, `cron`
- **Versionering:** Git, GitHub
- **Dokumentation:** Markdown, screenshots, `README.md`, `Slutrapport.docx`

---

##  Status (per 2025-06-11)

- [x] Ubuntu Server installerad i VMware
- [x] Alla nätverkstjänster driftsatta och testade
- [x] Slutrapport färdigställd och publicerad
- [x] GitHub-repo upprättat och dokumentation på plats
