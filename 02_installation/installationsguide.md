# Installationsguide

Denna mapp innehåller installationsguide för labbservern i LIA-projektet.

## Systeminformation

- **Operativsystem:** Ubuntu Server 22.04.5 LTS (64-bit)
- **Installationstyp:** Minimal, med OpenSSH-server
- **Virtuell miljö:** VMware Workstation 17 Pro (Windows 11 Host)
- **ISO-fil:** `ubuntu-22.04.5-live-server-amd64.iso`

## Språk & Tangentbord

- **Språk:** Engelska
- **Tangentbord:** Svenska

## Uppdatering

- Ubuntu föreslog uppgradering till 24.04 – detta avböjdes
- Installerad version enligt ISO: 22.04.5 LTS

## Nätverkskonfiguration

- DHCP användes automatiskt
- Anslutning till internet fungerade direkt

## Lagringskonfiguration

- **Disk:** `/dev/sda` (20 GB)
- **LVM:** Aktiverad
- **Root-partition:** `/` – 10 GB, ext4
- **Boot-partition:** `/boot` – 1.7 GB, ext4
- **Kryptering:** LUKS ej aktiverat
- **Metod:** Guidat installationsval (standard)

## Användarkonto

- **Namn:** Gustav Smith
- **Servernamn:** `lia-server`
- **Användarnamn:** `localadmin`
- **Lösenord:** `l1a!LINUX` (tillfälligt, ska bytas efter installation)
- **Behörighet:** Sudo

## SSH-konfiguration

- **OpenSSH-server:** Installerad
- **Lösenordsautentisering:** Tillåten (kan ändras senare)

## Snap-paket

- Inga snap-paket installerades vid installationen

## Vanliga problem

### Fel vid avmontering av installationsmedium

I slutet av installationen kan följande felmeddelande visas:

[FAILED] Failed unmounting /cdrom.
Please remove the installation medium, then press ENTER:


#### Orsak
Installationsprogrammet försöker avmontera ISO-filen, men eftersom den fortfarande är ansluten i den virtuella maskinen misslyckas det.

#### Lösning
1. Stäng av den virtuella maskinen i VMware.
2. Gå till VM-inställningarna.
3. Välj **CD/DVD (IDE)**.
4. Avmarkera alternativet **"Connect at power on"**.
5. Starta om maskinen.

Systemet ska nu starta från den installerade hårddisken utan problem.




