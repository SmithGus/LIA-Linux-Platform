# Projektplan – LIA: Linuxplattform

**Student:** Gustav Smith  
**Utbildning:** Nätverkstekniker, TUC  
**LIA-period:** 6 veckor

## Syfte
Sätta upp en säker Linuxbaserad servermiljö med centrala nätverkstjänster, övervakning och containerhantering.

## Mål
- Ubuntu Server LTS installation
- Docker Compose (alla containrar)
- Chrony (NTP-server)
- DHCP (container)
- DNS (BIND9, container)
- Syslog (rsyslog, container)
- Zabbix server & agent (container)
- Mailhog (container, notifieringstest)
- Automatiseringsskript: backup & tjänststatus
- Säkerhet: SSH-nyckel, UFW, fail2ban, least privilege
- Dokumentation i Markdown på GitHub

## Tidsplan & leverabler

| Vecka | Delmoment                                      | Leverabler                             |
|-------|------------------------------------------------|----------------------------------------|
| 1     | Projektplan, kravspec, riskanalys              | Projektplan.md, Kravspec.md, Risk.md   |
| 2     | Basinstallation, härdning, Chrony              | Harden-checklista.md, chrony.conf      |
| 3     | DHCP, DNS (container)                          | docker-compose.yml, konfigfiler        |
| 4     | Syslog, logrotate, automationskript (container)| docker-compose.yml, skript             |
| 5     | Zabbix, Mailhog (container)                    | docker-compose.yml, mallar             |
| 6     | Test, felsökning, slutrapport, demo            | Slutrapport.md, demo                   |

## Risker & åtgärder
Felkonfig, tidsbrist, systemfel, säkerhetsbrist, Dockerproblem, notifieringsmissar → Förebygga med dokumentation, test, backup, versionering, säkerhetshärdning.

## Verktyg
Ubuntu Server 22.04.5, Docker Compose, Chrony, isc-dhcp-server, BIND9, rsyslog, logrotate, Zabbix, Mailhog, Bash, Git, GitHub, Markdown.

## Status (2025-06-09)
- [x] Projektstart
- [x] Serverinstallation
- [X] Chrony klar
- [X] Docker Compose & containrar
- [X] Automatisering
- [ ] Slutrapport och demo
