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


## SSH-nyckelbaserad inloggning

För att verifiera att SSH-inloggning sker med nyckel (inte lösenord)

```bash
sudo cat ~/.ssh/authorized_keys
```
Detta visar att en nyckel är registrerad för användaren och används vid inloggning.


## DHCP - Automatisk IP-adresshantering

### Syfte
DHCP används för att automatiskt tilldela IP-adresser till klienter.

### Installerad programvara
- isc-dhcp-server

### Konfigurationsfil
**Plats: `/etc/dhcp/dhcpd.conf`**

```bash
subnet 192.168.181.0 netmask 255.255.255.0 {
  range 192.168.181.100 192.168.181.150;
  option routers 192.168.181.1;
  option domain-name-servers 8.8.8.8;
  default-lease-time 600;
  max-lease-time 7200;
}
```

Plats: /etc/default/isc-dhcp-server
INTERFACESv4="ens33"

Verifiering:

Sudo systemctl status isc-dhcp-server
sudo dhcpd -t 

Tjänsten visade active (running) och lyssnar på interface "ens33" 


## DHCP-server - isc-dhcp-server

DHCP Installerades och konfigurerades automatiskt med hjälp av scriptet `setup_dhcp.sh`i `04_scripts`

Scriptet:
- Installerar `ìsc-dhcp-server`
- Uppdaterar gränssnittet till `ens33`
- Skapar en enkel `/etc/dhcp/dhcpd.conf`
- Startar och aktiverar tjänsten

## Verifiering

```bash
sudo systemctl status isc-dhcp-server
sudo dhcpd -t
```
Tjänsten visar `active (running)`och lyssnar på interface `ens33`



# NTP-konfiguration med Chrony

Denna konfiguration syftar till att synkronisera systemtid mellan mina två servrar i ett lokalt nätverk. 

- **lia-server** agerar som NTP-master (anslutern till internet) 
- **lia-slave** synkar tid från lia-server

---

## nätverksinställningar

Server:		Gränssnitt: 	IP-adress: 	Kommentar:

Lia-server	ens37		192.168.181.10  NTP-server (har kontakt med internet) 

Lia-slave	ens33		192.168.181.11	synkar tid från lia-server (har inget internet)

---

## Steg 1 - installera chrony

```bash
sudo apt install chrony
```

På lia-slave behövde vi skicka chrony installationsfillen från lia-servern eftersom lia-slave inte har internet åtkomst. Därefter installerades den med: 

sudo dpkg -i chrony_*.deb 

Lia-server som NTP-server
/etc/chrony/chrony,conf:
allow 192.168.181.0/24

starta om tjänsten: 

sudo systemctl restart chrony

Tillåt trafiken i UFW

sudo ufw allow 123/udp

Steg 3 - lia-slave som NTP-klient
server 192.168.181.10 iburst


Verifiering:
chrony sources
chronyc tracking   

 
## Central loggning med rsyslog och logrotate

### Syfte
Målet är att samla in loggar centralt från `lia-slave`till `lia-server`med hjälp av `rsyslog`, och sedan hantera loggfiflerna med `logrotate`. 

---

### Server (lia-server)

### 1. Installera rsyslog o skapa loggmapp

```bash
sudo apt install rsyslog -y
sudo mkdir -p /var/log/remote
sudo chown syslog:adm /var/log/remote
sudo ufw /allow 514/udp
```
### 2. konfigurera rsyslog

Fil: /etc/rsyslog.d/10-remote.conf

module(load="imudp")
input(type="imudp" port="514")

$template RemoteLogs,"/var/log/remote/%fromhost-ip%.log"
*.* ?RemoteLogs

--- 

Starta om tjänsten:

sudo systemctl restart rsyslog

--- 

### 3. konfigurera logrotade 

Installera logrotate: 

sudo apt install logrotate -y

Skapa fil: /etc/logrotade.d/remote-logs

/var/log/remote/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 0640 syslog adm
} 

Testkörning: 
sudo logrotate -f /etc/loogrotate.d/remote-logs

--- 


### Klient (lia-slave)


## 1. installera rsyslog manuellt

Eftersom lia-slave saknar internet, laddades .deb-paketet för rsyslog ner på lia-server med:

apt download rsyslog

Därefter överfördes paketet till lia-slave via SCP:

scp rsyslog_*.deb lia-slave@192.168.181.11:/home/lia-slave/

Installationen på lia-slave:

sudo dpkg -i rsyslig_*.deb

## Skapa klientkonfig

Fil: /etc/rsyslog.d/50-remote.conf

*.* @192.168.181.10:514  #riktad till lia-server

Starta om tjänsten:

sudo systemctl restart rsyslog


Test och verifiering:

Skicka testlogg från lia-slave:
logger "testlogg från lia-slave"

Kontrollera på lia-server:
ls /var/log/remote/
tail /var/log/remote/192.168.181.11.log

Notering: 
- Lia-srver samlar loggar från flera klienter i separata filer med hjälv av %fromhost-ip%
- lia-slave, behöver ingen egen logrotate eftersom inga loggar lagras lokalt. 
- Installationen av rsyslog på lia-slave genomfördes via manuell överföring från lia-server på grund av birst på internetanslutning. 

--- 




## Cron: Automatiska uppgifter

Två viktiga cron-jobb har lagts till på `lia-server` för att automatisera säkerhetskopiering och tjänsteövervakning.

### 1. backup-configs.sh

**Syfte:** Säkerhetskopierar viktiga systemfiler till `/var/backups/configs-YYYYMMDD_HHMMSS`.

**Schema:** Körs varje natt kl. 02:00.

```cron
0 2 * * * /home/localadmin/LIA-Linux-Platform/04_scripts/backup-configs.sh >> /var/log/backup-configs.log 2>&1

---

2. check-services.sh

Syfte: Kontrollerar status för systemtjänster och loggar resultatet till syslog.

Schema: Körs varje hel timme.

0 * * * * /home/localadmin/LIA-Linux-Platform/04_scripts/check-services.sh >> /var/log/check-services.log 2>&1

0 * * * * /home/localadmin/LIA-Linux-Platform/04_scripts/check-services.sh >> /var/log/check-services.log 2>&1


Loggfiler:

    /var/log/backup-configs.log

    /var/log/check-services.log

    Samt inlägg i /var/log/syslog via logger


Redigering av root's crontab

För att redigera och kontrollera rootens cron:

sudo crontab -e
sudo crontab -l

Versionshantering

Skriptfilerna som körs via cron ligger i:

LIA-Linux-Platform/04_scripts/

De är versionerade i GitHub och har getts körbehörighet via:

chmod +x backup-configs.sh
chmod +x check-services.sh





