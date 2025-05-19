## UFW - Brandväggskonfiguration

För att skydda servern är UFW aktiverad och konfigurerad med följande regler:

### Syfte
UFW används för att: 
- Minska attacker
- Blockera all oönskad inkommande traffik
- Tillåta endast definerad tjänster

### Tillåtna portar

Tjänst   |   Port   |   Protokoll   |   Syfte

OpenSSH  |   22     |   TCP         |   Fjärradministration

HTTP     |   80     |   TCP         |   För framtida webbapplikation (kanske)

HTTPS    |   443    |   TCP         |   Krypterad webbtrafik 

Zabbix Server   |  10051  |    TCP  |   Övervakning via Zabbix 


### Kommandohistorik

```bash

- `sudo ufw allow OpenSSH`
- `sudo ufw allow http`
- `sudo ufw allow https`
- `sudo ufw allow 10051/tcp`
- `sudp ufw enable`

Se `04_scripts/setup_ufw.sh`för automatiserad konfiguration. 


