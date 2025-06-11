# 02 – Installation & Härdning

Denna mapp innehåller dokumentation för installation och härdning av Ubuntu Server inför tjänstedrift.

---

##  Systeminfo

- **OS:** Ubuntu Server 22.04.5 LTS
- **Plattform:** VMware Workstation 17
- **Nätverk:**  
  - `ens33`: NAT (internet)  
  - `ens37`: isolerat labbnät
- **Disk:** 30 GB (ökades vid behov)

---

## Säkerhetsinställningar

- Root-inloggning inaktiverad via SSH
- SSH-nyckelautentisering (lösenord avstängt)
- UFW-brandvägg:
  - Tillåter endast portar 22, 514, 123 etc.
- Fail2ban för att skydda SSH
- Tidssynkronisering med Chrony

---

## Viktiga filer i denna mapp

- `chrony.conf` – NTP-konfiguration
- `ufw-rules.txt` – exporterade brandväggsregler
- `sshd_config` – SSH-inställningar
- `fail2ban-jail.local` – aktiva skydd mot intrång
- `interface-info.txt` – IP- och nätverkskortsinformation

---

## Verifiering

| Test                     | Resultat                      |
|--------------------------|-------------------------------|
| `chronyc tracking`       | Tidssynk OK                   |
| SSH med nyckel           | Lösenord = nekas              |
| `ufw status`             | Brandvägg aktiv               |
| `fail2ban-client status` | Aktiva skydd registrerade     |

---

