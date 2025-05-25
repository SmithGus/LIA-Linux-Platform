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

 





