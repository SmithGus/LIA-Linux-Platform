## Hardening Checklist

En sammanställning av grundläggande säkerhetsåtgärder som finns på servern. 


## Genomförda åtgärder

- [X] Uppdaterat systemet (`sudo apt update && sudo apt upgrade`)
- [X] Inaktiverat root-inloggning via SSH
- [X] Aktiverat brandvägg (UFW)
- [X] Öppnat endast nödvändiga portar:
  - 22/tcp (OpenSSH)
  - 80/tcp (HTTP)
  - 443/tcp (HTTPS)
  - 10051/tcp (Zabbix-agent) 
- [X] Aktiverat och konfigurerat Fail2ban för SSH-skydd
- [X] Aktiverat SSH-nyckelbaserad inloggning 
- [X] Skapat en sudo-användare
- [X] Verifierat att UFW är aktiv (`sudo ufw status`) 
- [X] Verifierat att Fail2ban fungerar (`sudo fail2ban-client status sshd`)


> Denna checklista uppdateras löpande under projektets gång.
