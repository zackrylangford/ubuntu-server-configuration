#!/bin/bash

domain_name="$1"  # Get domain name from script argument

# Install and Configure stunnel
sudo apt-get install -y stunnel4

# Configure stunnel with the provided domain
echo -e "pid = /var/run/stunnel4/stunnel.pid\noutput = /var/log/stunnel4/stunnel.log\n\n[rtmps]\nclient = no\naccept = 8443\nconnect = 127.0.0.1:1935\ncert = /etc/letsencrypt/live/$domain_name/fullchain.pem\nkey = /etc/letsencrypt/live/$domain_name/privkey.pem" | sudo tee /etc/stunnel/stunnel.conf

sudo systemctl enable stunnel4
sudo systemctl start stunnel4
