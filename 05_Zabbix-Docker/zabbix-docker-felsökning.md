# Felsökning, installation och igångkörning av Zabbix i Docker

## Sammanfattning av åtgärder vid vanliga problem

1. **Se till att använda en stödd version av MySQL eller MariaDB**
   - Kontrollera i Zabbix-dokumentationen vilken databasversion som stöds för din Zabbix-version.
   - Byt till rätt version i din `docker-compose.yml` eller i `docker run`-kommandot.
   - Om Zabbix-servern loopar eller kraschar, kontrollera loggar (`docker logs <container>`) för versions- eller kompatibilitetsfel.

2. **Verifiera och konfigurera Docker-portmappning**
   - Ange korrekt portmappning (t.ex. `8000:8080`) i `docker-compose.yml` eller `docker run`.
   - Kontrollera med `docker ps` att portarna verkligen är mappade som du tänkt.
   - Testa lokalt på servern med `curl http://localhost:8000` för att verifiera att tjänsten svarar.

3. **Lägg till och kontrollera brandväggsregler**
   - Lägg till en UFW-regel för den externa porten, t.ex.:
     ```
     sudo ufw allow 8000/tcp
     sudo ufw reload
     ```
   - Kontrollera UFW-regler med `sudo ufw status numbered`.
   - Om du kör i molnplattform, kontrollera även eventuella säkerhetsgrupper/firewall-regler i molnleverantörens kontrollpanel.

4. **Dubbelkolla Docker-nätverk och nätverksläge**
   - Kontrollera att alla containrar är anslutna till rätt nätverk (`docker network ls` och `docker network inspect <nätverksnamn>`).
   - Om du använder flera nätverk (t.ex. `default` och `zabbix-net`), kontrollera att web- och db-containrarna hittar varandra.

5. **Verifiera tjänsternas hälsa och loggar**
   - Kontrollera att alla containrar är igång (`docker ps`).
   - Läs loggar för respektive container (`docker logs <container>`) för att hitta eventuella felmeddelanden.
   - Se till att webbtjänsten (t.ex. nginx eller Apache) och databasen startar utan fel.

6. **Lägg till och använd healthchecks i docker-compose**
   - Definiera healthchecks för dina tjänster i `docker-compose.yml` för att säkerställa att containrarna faktiskt är friska och redo innan andra tjänster försöker ansluta.
   - Exempel:
     ```yaml
     healthcheck:
       test: ["CMD", "curl", "-f", "http://localhost:8080"]
       interval: 30s
       timeout: 10s
       retries: 5
     ```
   - Kontrollera status med `docker ps` (se kolumnen "STATUS" för "healthy").

7. **Testa åtkomst från både server och klient**
   - Testa först lokalt på servern (`curl http://localhost:8000`).
   - Testa sedan från din klientdator i samma nätverk (`curl http://<server-ip>:8000`).
   - Om det fungerar med curl men inte i webbläsare, kontrollera att du använder rätt adress/port och att inga proxy/fjärrskrivbordsinställningar blockerar.

8. **Dokumentera eventuella specialinställningar**
   - Spara ändringar du gör i t.ex. `nginx.conf`, `docker-compose.yml`, eller UFW-regler.
   - Dokumentera särskilda nätverks- eller miljövariabler i din docker-compose-fil.

9. **Om du fortfarande har problem:**
   - Kontrollera att ingen extern brandvägg (router eller liknande) blockerar porten.
   - Testa från flera olika klienter om möjligt.
   - Dubbelkolla namnuppslagning/DNS om du använder servernamn istället för IP-adress.

---

## Exempel på felsökningskommandon

```bash
docker ps
docker logs <container>
docker network ls
docker network inspect <nätverksnamn>
sudo ufw status numbered
curl http://localhost:8000
curl http://<server-ip>:8000
sudo ss -tlnp | grep 8000
```

---

## Tips

- Jobba metodiskt: verifiera en sak i taget (databas, webb, nätverk, brandvägg).
- Skriv ner vad du ändrar och varför.
- Spara fungerande konfigurationer för framtiden.
