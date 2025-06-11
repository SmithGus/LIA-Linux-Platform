# DNS – Intern namnuppslagning med BIND9

Denna mapp innehåller konfiguration och verifiering av DNS-tjänsten **BIND9**, installerad på lia-servern. DNS gör det möjligt att nå interna resurser via namn istället för IP-adresser.

---

## Syfte

Att skapa en intern DNS-server ger snabbare och säkrare åtkomst till interna resurser samt möjlighet till domännamnssättning i det lokala nätverket. DNS-forwarding till internet säkerställer att även externa adresser kan nås.

---

## Installation, aktivering och start

```bash
sudo apt update
sudo apt install bind9 bind9utils bind9-doc
sudo systemctl enable bind9
sudo systemctl start bind9
```
