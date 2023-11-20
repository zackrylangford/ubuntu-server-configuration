#!/bin/bash

domain_name="$1"  # Get domain name from script argument

# Prompt for email address
read -p "Enter the email address for SSL certificate notifications: " email_address

sudo apt-get install -y certbot python3-certbot-nginx

# Obtain and Install a Certificate
sudo certbot --nginx -d "$domain_name" --non-interactive --agree-tos --email "$email_address"

# Set Up Automatic Renewal
(echo "15 3 * * * root certbot renew --quiet") | sudo tee -a /etc/crontab
