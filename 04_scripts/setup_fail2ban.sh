#!/bin/bash
sudo apt update
sudo apt install -y fail2ban

cat <<EOF | sudo tee /etc/fail2ban/jail.local
[sshd]
enabled = true
port = ssh
filter = sshd
logpath  = /var/log/auth.log
maxretry = 3
bantime = 60
findtime = 60
EOF

sudo systemctl enable fail2ban
sudo systemctl start fail2ban


