#!/bin/bash

UPLOAD_DIR="/var/www/livestream-archives"
BUCKET_NAME="YOUR_BUCKET_NAME_HERE"

# Find the latest file in the directory
LATEST_FILE=$(ls -Art $UPLOAD_DIR | tail -n 1)
if [[ -f "$UPLOAD_DIR/$LATEST_FILE" ]]; then
    # Upload to S3
    aws s3 cp "$UPLOAD_DIR/$LATEST_FILE" "s3://$BUCKET_NAME/$LATEST_FILE" && rm -f "$UPLOAD_DIR/$LATEST_FILE"
fi
