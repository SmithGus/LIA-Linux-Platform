## UFW - Brandväggskonfiguration

För att skydda servern är UFW aktiverad och konfigurerad med följande regler:

- `sudo ufw allow OpenSSH`
- `sudo ufw allow http`
- `sudo ufw allow https`
- `sudo ufw allow 10051/tcp`
- `sudp ufw enable`

Se `04_scripts/setup_ufw.sh`för automatiserad konfiguration. 


