CHECKLISTA.md
# CHECKLISTA – LIA: Linuxplattform för nätverkstjänster & övervakning

> Student: Gustav Smith  
> Period: 6 veckor (heltid)  
> Mål: Installera, konfigurera och dokumentera DHCP, DNS, Syslog, Zabbix på Ubuntu Server

#  FÖRBEREDELSE

- [X] Skapa GitHub-konto
- [X] Installera Git på Ubuntu-servern
- [X] Skapa nytt GitHub-repo för projektet
- [X] Klona projektet till servern (`git clone ...`)
- [X] Skapa mappstruktur enligt projektplan

# VECKA 1 – Projektplanering

- [X] Skriv klart `projektplan.md`
- [X] Skriv `riskanalys.md` (minst 3 risker + åtgärder)
- [X] Skapa nätverksdesign (topologi) och spara som `topologi.png`
- [X] Skriv `README.md` med projektbeskrivning
- [X] Push alla filer till GitHub

# VECKA 2 – Installation och härdning

- [X] Installera Ubuntu Server i VM (VirtualBox/VMware)
- [X] Skapa ny sudo-användare
- [X] Aktivera SSH-nyckelbaserad inloggning
- [X] Installera och konfigurera UFW (brandvägg)
- [X] Installera och konfigurera fail2ban
- [X] Installera och konfigurera NTP
- [X] Skapa `hardening_checklist.md`
- [X] Ta skärmbilder på installation och inställningar
- [X] Push till GitHub

# VECKA 3 – DHCP & DNS

- [X] Installera `isc-dhcp-server`
- [X] Skapa och testa `dhcpd.conf`
- [X] Installera och konfigurera BIND9 (DNS)
- [X] Skapa intern zonfil + forwarder
- [X] Skapa Master/Slave DNS för redudans
- [X] Testa `dig`, `nslookup` mot servern
- [ ] Beskriv redundans (teoretiskt)
- [X] Push zonfiler + konfig till GitHub

#  VECKA 4 – Syslog + Automatisering

- [ ] Installera och konfigurera `rsyslog`
- [ ] Konfigurera `logrotate` för logghantering
- [ ] Skriv `backup-configs.sh` (säkerhetskopiering)
- [ ] Skriv `check-services.sh` (status → syslog)
- [ ] Lägg skripten i `04_scripts/` och kommentera dem
- [ ] Testa båda skript via cron
- [ ] Push skript + konfigfiler

#  VECKA 5 – Zabbix & notifiering

- [ ] Installera Zabbix-server + agent (via DOCKER-COMPOSE)
- [ ] Lägg till minst 1 host (t.ex. dig själv)
- [ ] Skapa notifiering (e-post/SMS om möjligt)
- [ ] Skapa och exportera egen Zabbix-template
- [ ] Dokumentera Zabbix-inställningar i `zabbix-konfig.md`
- [ ] Push exportfil + dokumentation

#  VECKA 6 – Test, felsökning & slutrapport

- [ ] Verifiera att alla tjänster startar automatiskt
- [ ] Testa övervakning och notifiering
- [ ] Skriv `troubleshooting_log.md` (minst 3 problem + lösningar)
- [ ] Skriv slutrapport (`slutrapport.docx`, ca 10–15 sidor)
- [ ] Skriv `lia-dagbok.md` för alla veckor
- [ ] Skapa 5–10 presentationsbilder till demo
- [ ] Genomför demo via Zoom/Teams
- [ ] Push allt till GitHub

#  VG-extra 
- [ ] Implementera TLS-krypterad syslog (RFC 5425)
- [ ] Beskriv redundans med sekundär DNS (teoretiskt)
- [ ] Använd `cron` för automatisering
- [ ] Skapa `feature_checklist.md` där du bockar av alla delar

