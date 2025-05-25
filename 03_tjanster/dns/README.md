# DNS-konfiguration (lia-server & lia-slave)

Detta dokument beskriver hur DNS-tjänsten BIND9 har konfigurerats i två Ubuntu-servermiljöer: en **master (lia-server)** och en **slave (lia-slave)**.

Syftet är att skapa en redundant intern DNS med framåt- och bakåtuppslagning samt fungerande zonöverföring (AXFR).

---

## 1. Nätverksinställningar

### lia-server
 Gränssnitt | Typ       | IP-adress       | Kommentar                      

 ens33      | DHCP      | 192.168.181.x    | Används för GitHub/internet    
 ens37      | Statiskt  | 192.168.181.10/24| Intern zonmaster för DNS 

**VMware-inställning:**
- ens33 kopplad till NAT (VMnet8)
- ens37 kopplad till Host-only (VMnet1 eller liknande)

### lia-slave
 Gränssnitt | Typ       | IP-adress       | Kommentar                      

 ens33      | Statiskt  | 192.168.181.11/24| För zonöverföring & uppslagning

**VMware-inställning:**
- ens33 kopplad till samma Host-only-nätverk som lia-server (t.ex. VMnet1)

**Netplan-konfiguration på lia-server (`/etc/netplan/50-cloud-init.yaml`)**
```yaml
network:
  version: 2
  ethernets:
    ens33:
      dhcp4: true
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
    ens37:
      dhcp4: no
      addresses:
        - 192.168.181.10/24
```

**Netplan-konfiguration på lia-slave (`/etc/netplan/50-cloud-init.yaml`)**
```yaml
network:
  version: 2
  ethernets:
    ens33:
      dhcp4: no
      addresses:
        - 192.168.181.11/24
```

---

## 2. Masterkonfiguration (lia-server)

### `/etc/bind/named.conf.options`
```bash
options {
    directory "/var/cache/bind";

    listen-on { any; };
    allow-query { any; };
    allow-transfer { 192.168.181.11; };

    dnssec-validation auto;
};
```

### `/etc/bind/named.conf.local`
```bash
zone "internal.local" {
    type master;
    file "/etc/bind/db.internal.local";
    allow-transfer { 192.168.181.11; };
};

zone "181.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192";
    allow-transfer { 192.168.181.11; };
};
```

### `/etc/bind/db.internal.local`
```bash
$TTL 604800
@ IN SOA lia-server.internal.local. root.internal.local. (
        2         ; Serial
   604800         ; Refresh
    86400         ; Retry
  2419200         ; Expire
   604800 )       ; Negative Cache TTL
;
@       IN  NS      localhost.
@       IN  NS      lia-server.internal.local.
@       IN  A       127.0.0.1
@       IN  AAAA    ::1
lia-server  IN  A   192.168.181.10
lia-slave   IN  A   192.168.181.11
```

### `/etc/bind/db.192`
```bash
$TTL 604800
@ IN SOA lia-server.internal.local. root.internal.local. (
        2         ; Serial
   604800         ; Refresh
    86400         ; Retry
  2419200         ; Expire
   604800 )       ; Negative Cache TTL
;
@       IN  NS      lia-server.internal.local.
10      IN  PTR     lia-server.internal.local.
11      IN  PTR     lia-slave.internal.local.
```

---

## 3. Slavekonfiguration (lia-slave)

### `/etc/bind/named.conf.local`
```bash
zone "internal.local" {
    type slave;
    masters { 192.168.181.10; };
    file "/var/cache/bind/db.internal.local";
};

zone "181.168.192.in-addr.arpa" {
    type slave;
    masters { 192.168.181.10; };
    file "/var/cache/bind/db.192";
};
```

---

## 4. Internetuppslagning med forwarders

För att tillåta att DNS-masterservern (lia-server) vidarebefordrar DNS-förfrågningar till externa namnservrar (t.ex. Google eller Cloudflare) har vi aktiverat en forwarders-sektion i BIND-konfigurationen.

### Redigerad fil: `/etc/bind/named.conf.options`

```bash
options {
    directory "/var/cache/bind";

    forwarders {
        8.8.8.8;
        1.1.1.1;
    };

    dnssec-validation auto;

    listen-on-v6 { any; };
    listen-on { any; };
    allow-query { any; };
};

```

---


## 5. Verifiering

### a) Testa zonöverföring (från lia-slave):
```bash
dig AXFR internal.local @192.168.181.10
```

### b) Framåtuppslagning
```bash
dig lia-server.internal.local @127.0.0.1
```

### c) Bakåtuppslagning
```bash
dig -x 192.168.181.10 @127.0.0.1
```

### d) Kontrollera BIND-status
```bash
sudo systemctl status bind9
```

### e) Kontrollera loggning:
```bash
sudo journalctl -u bind9 -b
sudo tail -f /var/log/syslog | grep named
```

---
