# Nätverksinställningar - LIA-Plattform

Den här mappen innehåller dokumentation av nätverkskonfigurationer för servermiljön i min LIA-labb. Alla Servar använder statisk IP-adresser, konfigurerade via Netplan. 


## LIA-server

- **ROLL:** Primär server för DHCP, DNS, SYSLOG
- **Gränssnitt:** `ens33`
- **Statisk IP:** `192.168.181.10`
- **Gateway:** `192.168.181.2`
- **DNS:** `8.8.8.8.`, `1.1.1.1`

### Netplan-konfiguration (`/etc/netplan/50-cloud-init.yaml`)

```yaml
network: 
  version: 2
  ethernets:
    ens33:
      dhcp4: no
      addresses:
	- 192.168.181.10/24
      nameservers:
	addresses:
	  - 8.8.8.8
	  - 1.1.1.1
      routes: 
	- to: 0.0.0.0/0
	  via: 192.168.181.2

## Verifiering 

Ip a
ip route
ping -c 3 8.8.8.8
ping -c 3 google.com


Övrigt: Alla IP-adresser är anpassade till VMnet8 (NAT) i VMware Workstation där gateway normalt är 192.168.181.2

Ytterligare servrar tex Lia-slave dokumenteras här i efterhand. 
	
