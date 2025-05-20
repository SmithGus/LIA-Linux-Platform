## UFW - Brandväggskonfiguration

För att skydda servern är UFW aktiverad och konfigurerad med följande regler:

### Syfte
UFW används för att: 
- Minska attacker
- Blockera all oönskad inkommande traffik
- Tillåta endast definerad tjänster

## Tillåtna portar

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
```

Script: `04_scripts/setup_ufw.sh`för automatiserad konfiguration. 





## Fail2ban - Skydd mot inloggningsattacker

Syfte: Blockera IP-adresser som misslyckas logga in för många gånger.

Konfiguration: /etc/fail2ban/jail.local

## Inställningar
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 60
findtime = 60

Fail2ban startades och verifierades med:
- `sudo systemctl status fail2ban`
- `sudo fail2ban-client status`
- `sudo fail2ban-client status sshd`

Script: `setup_fail2ban.sh` finns i 04_scripts





