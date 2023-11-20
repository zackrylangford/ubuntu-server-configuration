# Ubuntu RTMP Module Scripts

## Overview
This repository contains scripts for setting up an RTMP module on Ubuntu servers.

## Contents
- `certbot.sh`: Script for setting up Certbot for SSL certification.
- `install-rtmp.sh`: Main installation script for the RTMP module.
- `nginx.conf`: Nginx configuration file for the RTMP module.
- `rtmp`: RTMP configuration file.
- `stunnel.sh`: Script for setting up Stunnel.
- `upload_recording.py`: Python script to upload recordings to AWS S3.

## Usage
1. Clone this repository on your Ubuntu server.
2. Run `install-rtmp.sh` to start the installation process.
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

## Requirements
- An Ubuntu server
- A domain name (for SSL certification) pointed to the server IP address so that Certbot can verify the domain name
- Access to AWS for S3 uploads and permissions set up for your server to upload to S3(for `upload_recording.py`)


## Contributions
Feel free to fork this repository and contribute to its development.



# Updated steps
It looks like you need to seperate the installs for now. So, 

1. Run the install-nginx-rtmp.sh script
2. Run the certbot.sh script
3. Run the stunnel.sh script