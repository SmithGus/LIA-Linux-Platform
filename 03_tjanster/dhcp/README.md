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

## Exempelfil

Se [dhcpd.conf](./dhcpd.conf) för fullständig konfigurationsfil.

