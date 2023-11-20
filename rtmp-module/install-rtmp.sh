#!/bin/bash -xe
# Prompt for custom domain name
read -p "Enter the domain name (e.g., stream.example.com): " domain_name
read -p "Enter the S3 bucket name for uploads: " s3_bucket_name

echo "Starting RTMP configuration script"
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

# Copy the nginx.conf file into the proper directory
# Assuming nginx.conf is in the current directory where the script is run
sudo cp nginx.conf /etc/nginx/nginx.conf

# Dynamically update the rtmp.conf file with the provided server name
sed -i "s/stream.example.com/$domain_name/g" rtmp.conf

# Copy the RTMP configuration file to sites-enabled
# Assuming rtmp.conf is in the current directory where the script is run
sudo cp rtmp /etc/nginx/sites-enabled/rtmp

# Execute certbot.sh script to install Certbot and configure SSL
# Giving execute permissions to certbot.sh
chmod +x certbot.sh
./certbot.sh "$domain_name"

# Execute stunnel.sh script to install and configure stunnel
# Giving execute permissions to stunnel.sh
chmod +x stunnel.sh
./stunnel.sh "$domain_name"

# Update the Python script with the provided S3 bucket name
sed -i "s/YOUR_BUCKET_NAME_HERE/$s3_bucket_name/g" upload_recording.py

# Restart Nginx to apply new configuration
sudo systemctl restart nginx

echo "Nginx-RTMP install complete!"
