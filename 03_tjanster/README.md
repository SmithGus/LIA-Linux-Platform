# 03 – Tjänster: DHCP, DNS, Syslog, Zabbix

Denna mapp innehåller dokumentation för fyra centrala nätverkstjänster som driftsattes på lia-servern. Varje tjänst har en egen undermapp med konfigurationsfiler, testresultat och verifiering.

---

## Tjänsteöversikt

| Tjänst  | Syfte                                         | Verktyg / Paket              |
|---------|-----------------------------------------------|------------------------------|
| DHCP    | Automatisk IP-adresshantering för klienter    | isc-dhcp-server              |
| DNS     | Intern namnuppslag + vidarekoppling till internet | BIND9                   |
| Syslog  | Central logginsamling + loggrotation          | rsyslog + logrotate          |
| Zabbix  | Övervakning, triggers, e-postlarm             | Zabbix Server + Agent        |

---

## Mappstruktur

- [`dhcp/`](./dhcp) – DHCP-konfiguration, test med ipconfig
- [`dns/`](./dns) – Zonfiler, slavserver, `dig` och `AXFR`
- [`syslog/`](./syslog) – Rsyslog och logrotate-verifiering
- [`zabbix/`](./zabbix) – Zabbix-server + agent, notifieringstest

Varje mapp innehåller:
- Viktiga `.conf`-filer
- Kodkommentarer
- Testkommandon
- Verifieringsbilder (där det är relevant)
