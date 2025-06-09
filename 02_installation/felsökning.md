# Felsökningslogg – LIA Linux Plattform  
Gustav Smith – LIA-projekt  
Ubuntu Server 22.04 LTS · Docker Compose · Zabbix · BIND9 · rsyslog

---

## Zabbix-server startade inte

När jag startade zabbix-server i Docker fungerade det inte. Felet berodde på att MySQL-databasen inte var helt klar när servern försökte ansluta.

Jag löste det genom att lägga till `log_bin_trust_function_creators = 1` i MySQL och såg till att databasen fick starta först i docker-compose.

Senare upptäckte jag också att MySQL-versionen (5.7) var föråldrad och gav problem. Jag testade nyare versioner för bättre stabilitet och kompatibilitet.

---

## Zabbix-agent visades inte i GUI

Först installerade jag agenten direkt på lia-servern, men den dök inte upp i Zabbix-gränssnittet. Problemet var att servern kördes i Docker och kunde inte nå agenten via localhost eller hostens IP.

Jag flyttade istället agenten till en egen container och satte den i samma nätverk som servern (`zabbix-net`). Då fungerade kommunikationen direkt.

---

## DNS-slave fick inte zondata

Min DNS-slave fick inte zonfilen från master. Det berodde på att `allow-transfer` och `also-notify` saknades.

Jag la till slavens IP-adress i masters konfiguration och stängde av DNSSEC (`dnssec-validation no;`) eftersom slavservern inte har internetåtkomst.

---

## rsyslog med TLS (ANON)

Jag satte upp krypterad loggöverföring med rsyslog mellan lia-server och lia-slave. För enkelhetens skull använde jag TLS med ANON-autentisering istället för fullständig x509-verifiering.

Jag skapade egna certifikat och verifierade anslutningen med `openssl s_client`.

---

## Problem med fetch-glue i BIND9

Vid start av BIND9 fick jag ett felmeddelande om `fetch-glue`. Den inställningen används inte längre i nya versioner. Jag tog bort raden från `named.conf.options` och verifierade konfigurationen med `named-checkconf`.

---

## Docker-nätverk

Alla tjänster körs i Docker och ligger i ett gemensamt nätverk jag kallade `zabbix-net`. Det gör att zabbix-server, agent, web och mysql kan nå varandra via container-namn, utan att behöva exponera portar mot hosten.

---

## Healthchecks i Docker Compose

Jag lade till `healthcheck:` i `docker-compose.yml` för viktiga tjänster. Det gör det lättare att se om något inte är uppe och förenklar felsökning vid uppstart.

---

## Zabbix-verktyg saknades i Ubuntu

För att felsöka använde jag `zabbix_get` och `zabbix_sender`, men de fanns inte att installera direkt via apt i Ubuntu 22.04.

Jag laddade ner verktygen från Zabbix GitHub och körde dem manuellt.

Exempel:

```bash
zabbix_get -s zabbix-agent -k system.uptime
zabbix_sender -z zabbix-server -s lia-server -k custom.key -o "123"
