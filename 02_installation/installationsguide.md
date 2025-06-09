# Installationsguide

Denna guide beskriver grundinstallationen av labbservern för LIA-projektet.

---

## 1. Systeminformation

- **Operativsystem:** Ubuntu Server 22.04.5 LTS (64-bit)
- **Installationstyp:** Minimal med OpenSSH-server
- **Virtuell miljö:** VMware Workstation 17 Pro (Windows 11 Host)
- **ISO-fil:** `ubuntu-22.04.5-live-server-amd64.iso`

---

## 2. Språk & Tangentbord

- **Språk:** Engelska
- **Tangentbord:** Svenska

---

## 3. Uppdatering av system

- Ubuntu föreslog uppgradering till 24.04 – detta avböjdes.
- Installerad version enligt ISO: 22.04.5 LTS.
- Efter installation:  
  `sudo apt update && sudo apt upgrade -y`

---

## 4. Nätverkskonfiguration

- DHCP användes för första installationen (internet fungerade direkt).
- Statisk IP och övriga nätverksinställningar konfigureras senare i projektet.

---

## 5. Lagringskonfiguration

- **Disk:** `/dev/sda` (20 GB)
- **LVM:** Aktiverad
- **Root-partition:** `/` – 10 GB, ext4
- **Boot-partition:** `/boot` – 1.7 GB, ext4
- **Kryptering:** LUKS ej aktiverat
- **Metod:** Guidat installationsval (standard)

---

## 6. Användarkonto

- **Namn:** Gustav Smith
- **Servernamn:** `lia-server`
- **Användarnamn:** `localadmin`
- **Lösenord:** `l1a!LINUX` (tillfälligt, byts efter installation)
- **Behörighet:** Sudo

---

## 7. SSH-konfiguration

- **OpenSSH-server:** Installerad
- **Lösenordsautentisering:** Tillåten vid installation (ska ändras till SSH-nyckel senare)
- **Tips:** Byt lösenord och konfigurera SSH-nyckel så snart som möjligt.

---

## 8. Snap-paket

- Inga snap-paket installerades vid installationen.

---

## 9. Installation av Docker och Docker Compose

- Installera Docker:
  ```
  sudo apt update
  sudo apt install docker.io
  ```
- Installera Docker Compose:
  ```
  sudo apt install docker-compose
  ```
- Lägg till användaren i docker-gruppen (valfritt):
  ```
  sudo usermod -aG docker $USER
  ```
- Kontrollera installation:
  ```
  docker --version
  docker compose version
  ```

---

## 10. Installation av Chrony (NTP-server)

- Installera Chrony:
  ```
  sudo apt install chrony
  ```
- Starta och aktivera tjänsten:
  ```
  sudo systemctl enable --now chrony
  ```
- Kontrollera status:
  ```
  systemctl status chrony
  ```

---

## 11. Mailhog (för test av e-post)

- Mailhog körs som container via Docker Compose.
- Lägg till detta i din `docker-compose.yml`:
    ```yaml
    mailhog:
      image: mailhog/mailhog
      ports:
        - "8025:8025"   # Webbgränssnitt
        - "1025:1025"   # SMTP
    ```
- Starta Mailhog:
  ```
  docker compose up -d mailhog
  ```

---

## 12. Vanliga problem

### Fel vid avmontering av installationsmedium

I slutet av installationen kan följande felmeddelande visas:

```
[FAILED] Failed unmounting /cdrom.
Please remove the installation medium, then press ENTER:
```

**Orsak:**  
Installationsprogrammet försöker avmontera ISO-filen, men eftersom den fortfarande är ansluten i den virtuella maskinen misslyckas det.

**Lösning:**  
1. Stäng av den virtuella maskinen i VMware.
2. Gå till VM-inställningarna.
3. Välj **CD/DVD (IDE)**.
4. Avmarkera alternativet **"Connect at power on"**.
5. Starta om maskinen.

Systemet ska nu starta från den installerade hårddisken utan problem.

---
