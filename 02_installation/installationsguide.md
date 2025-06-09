# Installationsguide – LIA-projekt

Den här guiden beskriver hur du installerar och konfigurerar labbservern (lia-server) samt viktiga tjänster för LIA-projektet.  
Alla steg är anpassade för Ubuntu Server 22.04.5 LTS.

---

## 1. Systemöversikt

| Tjänst        | Var/Typ          | Kommentar                                 |
|---------------|------------------|-------------------------------------------|
| DHCP-server   | lia-server (APT) | isc-dhcp-server, lokal nätutdelning       |
| DNS-master    | lia-server (APT) | BIND9, primär zonhantering                |
| DNS-slave     | lia-slave (APT)  | BIND9, redundans/slavkoppling             |
| NTP-server    | lia-server (APT) | Chrony                                    |
| Syslog        | lia-server (APT) | rsyslog + logrotate, central loggning     |
| Zabbix Server | Docker Compose   | Övervakning, körs som container           |
| Zabbix Agent  | Docker Compose   | Agent för övervakning                     |
| Mailhog       | Docker Compose   | Lokal testmailserver för notifieringar     |

---

## 2. Grundinstallation av Ubuntu Server

- **ISO-fil:** `ubuntu-22.04.5-live-server-amd64.iso`
- **Installationstyp:** Minimal ("Minimal installation"), välj med OpenSSH-server
- **Virtuell miljö:** VMware Workstation 17 Pro  
- **Värd:** Windows 11


---

## 3. Grundläggande systeminställningar

### Språk & Tangentbord

- Språk: Engelska
- Tangentbord: Svenska

### Systemuppdatering

```sh
sudo apt update && sudo apt upgrade -y
```

---

## 4. Nätverks- och lagringsinställningar

- DHCP används automatiskt vid installation.
- Statisk IP-adress och VLAN konfigureras i `/etc/netplan/` efteråt.
- Disk: `/dev/sda` (20 GB), LVM aktiverat, root `/` (10 GB), boot `/boot` (1.7 GB), ingen kryptering.

---

## 5. Användarkonto

- Användarnamn: `localadmin`
- Servernamn: `lia-server`
- Sudo rättigheter: Ja

---

## 6. SSH-konfiguration

- OpenSSH-server installerad
- Lösenordsautentisering aktiverad (byt till SSH-nyckel så snart som möjligt!)
- Exempel:  
  ```sh
  ssh-keygen
  ssh-copy-id localadmin@lia-server
  # Stäng sedan av lösenordsinloggning i /etc/ssh/sshd_config
  ```

---

## 7. Installation av tjänster via APT (på lia-server)

### DHCP-server

```sh
sudo apt install isc-dhcp-server
```
- Konfigurationsfil: `/etc/dhcp/dhcpd.conf`
- Ange rätt nätverksinterface i `/etc/default/isc-dhcp-server`

### DNS-server (BIND9 – Master)

```sh
sudo apt install bind9 bind9utils bind9-doc
```
- Konfigurationsfiler: `/etc/bind/named.conf.local`, zonfiler i `/etc/bind/zones/`
- Skapa och konfigurera minst en framåt- och en omvänd zon.
- Se till att DNS-slave (lia-slave) får slava zonen:
  - Lägg till `allow-transfer` och `also-notify` med lia-slave:s IP.

### NTP-server (Chrony)

```sh
sudo apt install chrony
```
- Konfigurationsfil: `/etc/chrony/chrony.conf`
- Starta och aktivera tjänsten:
  ```sh
  sudo systemctl enable --now chrony
  ```

### Syslog

```sh
sudo apt install rsyslog logrotate
```
- Central loggning konfigureras i `/etc/rsyslog.conf` och `/etc/rsyslog.d/`
- Loggrotation i `/etc/logrotate.conf` och `/etc/logrotate.d/`

---

## 8. DNS-slave (lia-slave)

På servern **lia-slave**:

```sh
sudo apt install bind9 bind9utils
```
- Lägg till slavzoner i `/etc/bind/named.conf.local`:
    ```text
    zone "example.local" {
      type slave;
      masters { <lia-server-IP>; };
      file "/var/cache/bind/example.local";
    };
    ```
- Kontrollera att rättigheter och IP för zonöverföring stämmer med master.

---

## 9. Docker och Docker Compose (på lia-server)

### Installera Docker

```sh
sudo apt install docker.io
```

### Installera Docker Compose

```sh
sudo apt install docker-compose
```
- Lägg till användaren i docker-gruppen (valfritt):
  ```sh
  sudo usermod -aG docker $USER
  ```

---

## 10. Docker Compose-tjänster (på lia-server)


```yaml
version: '3'
services:
  zabbix-server:
    image: zabbix/zabbix-server-pgsql:latest
    ports:
      - "10051:10051"
    environment:
      - DB_SERVER_HOST=postgres
      - POSTGRES_USER=zabbix
      - POSTGRES_PASSWORD=zabbixpass
      - POSTGRES_DB=zabbix
    depends_on:
      - postgres
    restart: unless-stopped

  postgres:
    image: postgres:15
    environment:
      - POSTGRES_USER=zabbix
      - POSTGRES_PASSWORD=zabbixpass
      - POSTGRES_DB=zabbix
    volumes:
      - ./pg_data:/var/lib/postgresql/data
    restart: unless-stopped

  zabbix-agent:
    image: zabbix/zabbix-agent:latest
    environment:
      - ZBX_SERVER_HOST=zabbix-server
    restart: unless-stopped

  mailhog:
    image: mailhog/mailhog
    ports:
      - "8025:8025"
      - "1025:1025"
    restart: unless-stopped
```

**Starta alla containrar:**
```sh
docker compose up -d
```

---


## 12. Checklista – efter installation

- [ ] Byt alla tillfälliga lösenord och spara dem säkert.
- [ ] Testa alla tjänster var för sig (DHCP, DNS, Chrony, Syslog, Zabbix, Mailhog).
- [ ] Kontrollera DNS-redundans genom att slå av master och se att slav svarar.
- [ ] Kontrollera att Zabbix och Mailhog är åtkomliga på respektive port.
- [ ] Kontrollera att loggning och tidsynk fungerar på klienter.

---
