# DHCP – Automatisk IP-adresshantering

Denna mapp innehåller konfiguration och verifiering för DHCP-tjänsten `isc-dhcp-server`, installerad på lia-servern. DHCP gör att klienter automatiskt får rätt IP-adress, gateway och DNS-inställningar.

---

## Syfte

DHCP används för att automatisera utdelning av IP-adresser i ett nätverk. Detta minskar risken för manuella fel, sparar tid vid klientinstallationer och gör det lätt att skala upp nätverket.

---

## Installation, aktivering och start

Installera DHCP-servern:

```bash
sudo apt update
sudo apt install isc-dhcp-server
```
---


/etc/default/isc-dhcp-server:
INTERFACESv4="ens37"

---

Aktivera och starta tjänsten:
sudo systemctl enable isc-dhcp-server
sudo systemctl start isc-dhcp-server

---

Kontrollera att tjänsten är igång:
sudo systemctl status isc-dhcp-server

---

Brandvägg (UFW)
Öppna port 67/UDP för DHCP-servern:
sudo ufw allow 67/udp

---

Konfiguration: /etc/dhcp/dhcpd.conf
# Subnätet som används i labbnätet
subnet 192.168.181.0 netmask 255.255.255.0 {

  # IP-range som tilldelas klienter
  range 192.168.181.50 192.168.181.250;

  # Gateway (router) för klienterna
  option routers 192.168.181.1;

  # DNS-server (t.ex. lokal BIND9-server)
  option domain-name-servers 192.168.181.10;

  # Domännamn som används internt (valfritt)
  option domain-name "internal.local";

  # Lease-tider (tidsgräns för IP-adress)
  default-lease-time 600;
  max-lease-time 7200;
}

---

Verifiering:





