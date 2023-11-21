#!/bin/bash

UPLOAD_DIR="/var/www/livestream-archives"
BUCKET_NAME="YOUR_BUCKET_NAME_HERE"

# Find the latest file in the directory
LATEST_FILE=$(ls -Art $UPLOAD_DIR | tail -n 1)
if [[ -f "$UPLOAD_DIR/$LATEST_FILE" ]]; then
    # Generate a timestamp
    TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

    # Generate new file name with timestamp
    NEW_FILE_NAME="${TIMESTAMP}-${LATEST_FILE}"

    # Upload to S3 with new file name
    aws s3 cp "$UPLOAD_DIR/$LATEST_FILE" "s3://$BUCKET_NAME/$NEW_FILE_NAME" && rm -f "$UPLOAD_DIR/$LATEST_FILE"
fi
