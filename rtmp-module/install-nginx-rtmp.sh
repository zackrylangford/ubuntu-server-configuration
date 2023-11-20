#!/bin/bash -xe

# Prompt for custom domain name and S3 bucket name
read -p "Enter the domain name (e.g., stream.example.com): " domain_name
read -p "Enter the S3 bucket name for uploads: " s3_bucket_name

echo "Starting RTMP configuration script"

# Update and install necessary packages
sudo apt-get update -y
sudo apt-get install -y nginx libnginx-mod-rtmp python3 python3-pip

# Install Boto3
sudo pip3 install boto3

# Create necessary directories
sudo mkdir -p /var/www/html/stream/hls
sudo mkdir -p /var/www/html/stream/dash
sudo mkdir -p /home/ubuntu/livestream-archives
sudo chown -R www-data:www-data /var/www/html/stream
sudo chown -R ubuntu:ubuntu /home/ubuntu/livestream-archives

# Copy the basic nginx.conf file into the proper directory
# This should be a basic configuration without SSL settings
sudo cp nginx.conf /etc/nginx/nginx.conf

# Reload Nginx with the basic configuration
sudo systemctl reload nginx

# Execute certbot.sh script to install Certbot and configure SSL
# Giving execute permissions to certbot.sh
chmod +x certbot.sh
./certbot.sh "$domain_name"

# Update the Nginx configuration with SSL settings
# This can be done by modifying the existing configuration or adding a new file in sites-available and then enabling it
# Assuming rtmp.conf is the SSL enabled configuration for the domain
sed -i "s/stream.example.com/$domain_name/g" rtmp.conf
sudo cp rtmp.conf /etc/nginx/sites-available/rtmp
sudo ln -sf /etc/nginx/sites-available/rtmp /etc/nginx/sites-enabled/rtmp

# Execute stunnel.sh script to install and configure stunnel (if necessary)
# Giving execute permissions to stunnel.sh
#chmod +x stunnel.sh
#./stunnel.sh "$domain_name"

# Update the Python script

# Update the Python script with the provided S3 bucket name
sed -i "s/YOUR_BUCKET_NAME_HERE/$s3_bucket_name/g" upload_recording.py

# Restart Nginx to apply new configuration
sudo systemctl restart nginx

echo "Nginx-RTMP install complete!"
