UPLOAD_DIR="/var/www/livestream-archives"
BUCKET_NAME="YOUR_BUCKET_NAME_HERE"
FILE_NAME="YOUR_FILE_NAME_HERE"

# Find the latest file in the directory
LATEST_FILE=$(ls -Art $UPLOAD_DIR | tail -n 1)
if [[ -f "$UPLOAD_DIR/$LATEST_FILE" ]]; then
    # Generate a date string in the MM-DD-YYYY format
    DATE_STR=$(date +"%m-%d-%Y")

    # Create the base new file name
    BASE_NEW_FILE_NAME="${FILE_NAME}${DATE_STR}"

    # Initialize the full new file name
    NEW_FILE_NAME="${BASE_NEW_FILE_NAME}.flv"

    # Initialize a counter
    COUNTER=1

    # Check if the file already exists in S3
    while aws s3 ls "s3://$BUCKET_NAME/$NEW_FILE_NAME" &> /dev/null; do
        # Append a counter to the file name if it already exists
        NEW_FILE_NAME="${BASE_NEW_FILE_NAME}-${COUNTER}.flv"
        let COUNTER=COUNTER+1
    done

    # Rename the latest file to the new name
    mv "$UPLOAD_DIR/$LATEST_FILE" "$UPLOAD_DIR/$NEW_FILE_NAME"

    # Upload to S3 with new file name
    aws s3 cp "$UPLOAD_DIR/$NEW_FILE_NAME" "s3://$BUCKET_NAME/$NEW_FILE_NAME" && rm -f "$UPLOAD_DIR/$NEW_FILE_NAME"
fi
