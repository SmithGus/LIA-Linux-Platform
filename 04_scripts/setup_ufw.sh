#!/bin/bash

# setup_ufw.sh - konfiguerar UFW-brandvägg

sudo ufw allow OpenSSH
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 10051/tcp
sudo ufw enable
sudo ufw status verbose

