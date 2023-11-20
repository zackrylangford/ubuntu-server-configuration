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

## Requirements
- An Ubuntu server
- Access to AWS for S3 uploads (for `upload_recording.py`)

## Contributions
Feel free to fork this repository and contribute to its development.
