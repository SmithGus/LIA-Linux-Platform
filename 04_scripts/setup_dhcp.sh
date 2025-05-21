#!bin/bash
# setup_dhcp.sh - installerar och konfiguerar DHCP-server

#Installera paketet
sudo apt update
sudo apt install -y isc-dhcp-server

sudo sed -i 's/^INTERFACESv4=.*/INTERFACESv4="ens33"/' etc/default/isc-dhcp-server

sudo tee /etc/dhcp/dhcpd.conf > /dev/null <<EOF
authoritative;

subnet 192.168.181.0 netmask 255.255.255.0 {
  range 192.168.181.100 192.168.181.150;
  option routers 192.168.181.1;
  option domain-name-servers 8.8.8.8
  default-lease-time 600;
  max-lease-time 7200;
} 
EOF

sudo touch /var/lib/dhcp/dhcpd.lease

sudo systemctl restart isc-dhcp-server
sudo systemctl enable isc-dhcp-server

echo "DHCP-server är installerad, konfigurerad och igång."


