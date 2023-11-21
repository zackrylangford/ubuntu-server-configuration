# Ubuntu RTMP Module Scripts

## Overview
This repository contains scripts for setting up an RTMP module on Ubuntu servers.

## Requirements
- An Ubuntu server set up with IAM roles and permissions to access AWS S3.
- An AWS S3 bucket for storing recordings.
- A domain name (for SSL certification) pointed to the server IP address so that Certbot can verify the domain name
- Proper security group settings that allow 443, 80, and 1935 open. 


## Contents
- `certbot.sh`: Script for setting up Certbot for SSL certification.
- `install-rtmp.sh`: Main installation script for the RTMP module.
- `nginx.conf`: Nginx configuration file for the RTMP module.
- `rtmp.conf`: RTMP configuration file.
- `stunnel.sh`: Script for setting up Stunnel.
- `upload_to_s3.sh`: Bash script to upload recordings to AWS S3.

## Usage
1. Clone this repository on your Ubuntu server.
2. Run `install-rtmp.sh` to start the installation process. You will be prompted to enter your domain name, s3 bucket for recordings, and email address for SSL certification.
3. Follow the on-screen prompts to complete the setup.
4. Run a verification afterwards to make sure you are set up correctly:
To verify that the RTMP module is running, run the following commands:
```
sudo systemctl status nginx 
```
To verify that Stunnel is running, run the following commands:
```
sudo systemctl status stunnel4
```
To verify nginx configuration, run the following command:
```
sudo nginx -t
```

## Notes
- Verify that you don't have conflicts with /etc/nginx/sites-enabled/default and the newly written /etc/nginx/sites-enabled/rtmp file. Certbot automatically adds server configuration to the default file so you may need to comment it out or remove it from the sites-enabled directory in order to avoid conflicting server setups. 


## Contributions
Feel free to fork this repository and contribute to its development.





