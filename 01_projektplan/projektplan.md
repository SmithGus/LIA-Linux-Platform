# Projektplan – LIA: Linuxplattform

## Studentinformation

Namn: Gustav Smith  
Utbildning: Nätverkstekniker, TUC Yrkeshögskola  
LIA-period: 6 veckor (heltid)

---

## Syfte

Projektet syftar till att bygga och driftsätta en säker Linux-baserad servermiljö för ett fiktivt medelstort företag. Servern ska leverera centrala nätverkstjänster såsom DHCP, DNS, logghantering via Syslog och aktiv övervakning med Zabbix. Projektet stärker mina praktiska färdigheter inom systemadministration, felsökning, säkerhet och dokumentation.

---

## Mål

- Installera och grundkonfigurera Ubuntu Server LTS  
- Driftsätta tjänster för DHCP, DNS, Syslog och Zabbix  
- Härda systemet med SSH-nycklar, UFW och fail2ban  
- Skriva minst två automatiseringsskript (backup + tjänstkontroll)  
- Dokumentera samtliga steg i GitHub med Markdown  
- Genomföra en slutlig presentation och demo  

---

## Tidsplan

| Vecka | Delmoment |
|-------|-----------|
| 1     | Projektplan, kravspecifikation, riskanalys |
| 2     | Installation av server och härdning |
| 3     | DHCP och DNS-tjänster |
| 4     | Syslog, logrotate och automatiseringsskript |
| 5     | Zabbix-server, mallar och notifieringar |
| 6     | Test, felsökning, slutrapport och demo |

---

## Status (senast uppdaterad: 2025-05-05)

- [x] Projektstart och GitHub klar  
- [ ] Serverinstallation  
- [ ] Tjänstekonfiguration  
- [ ] Automatisering  
- [ ] Slutrapport och demo  

---

## Risker och åtgärder

| Risk                        | Konsekvens                            | Åtgärd                                               |
|-----------------------------|----------------------------------------|------------------------------------------------------|
| Felkonfiguration av tjänst  | Tjänsten fungerar inte korrekt         | Dokumentera steg och testa varje moment             |
| Tidsbrist                   | Risk att vissa delar inte hinner testas | Följa tidsplan och arbeta dagligen                 |
| Systemfel eller korruption | Dataförlust eller omstart              | Regelbunden backup och versionshantering i Git     |

---

## Verktyg och resurser

- Ubuntu Server LTS (VM via VirtualBox eller VMware)  
- Git och GitHub för versionskontroll  
- Bash-skript  
- Dokumentation i Markdown
