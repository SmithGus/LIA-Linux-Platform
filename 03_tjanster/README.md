# 03 – Nätverkstjänster: DHCP, DNS, Syslog, Zabbix

Denna mapp innehåller dokumentation för fyra centrala nätverkstjänster som installerats och konfigurerats i projektet. Målet är att visa hur dessa tjänster samverkar för att skapa ett stabilt och övervakat nätverk i en Linuxbaserad miljö.

---

## Tjänsteöversikt

| Tjänst  | Funktion                                     | Programvara         |
|---------|----------------------------------------------|---------------------|
| DHCP    | Automatisk IP- och gateway-distribution      | isc-dhcp-server     |
| DNS     | Intern domänhantering och vidarekoppling     | BIND9               |
| Syslog  | Samlar loggar centralt + rotation            | rsyslog, logrotate  |
| Zabbix  | Övervakning med triggers och e-postlarm      | zabbix-server/agent |

---

## Mappstruktur och innehåll

Varje tjänst har en egen undermapp som innehåller:

- Konfigurationsfiler (`*.conf`) med kommentarer
- Test- och verifieringskommandon
- Eventuella verifieringsbilder
- En README-fil med pedagogisk förklaring

Strukturen är följande:

```text
03_tjanster/
├── dhcp/
│   └── dhcpd.conf, verifiering.png, README.md
├── dns/
│   └── named.conf.local, zonfiler, README.md
├── syslog/
│   └── rsyslog.conf, logrotate.conf, README.md
├── zabbix/
│   └── zabbix_server.conf, screenshots/, README.md
