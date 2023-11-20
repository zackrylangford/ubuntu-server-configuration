import boto3
import os
from datetime import datetime

s3 = boto3.client('s3')

def upload_files_to_s3_and_remove(bucket_name, folder_path):
    for file_name in os.listdir(folder_path):
        file_path = os.path.join(folder_path, file_name)

        # Get current date and time for the new file name
        current_datetime = datetime.now().strftime("%Y%m%d-%H%M%S")
        new_file_name = f"{current_datetime}-{file_name}"
        new_file_path = os.path.join(folder_path, new_file_name)

        # Rename the file with the new name
        os.rename(file_path, new_file_path)

        # Upload to S3 with the new file name
        s3.upload_file(new_file_path, bucket_name, new_file_name)
        
        # Verify if the upload was successful (Optional but recommended)
        if new_file_name in [obj['Key'] for obj in s3.list_objects(Bucket=bucket_name)['Contents']]:
            print(f'Successfully uploaded {new_file_name} to {bucket_name}. Removing local file.')
            
            # Remove the file
            os.remove(new_file_path)
        else:
            print(f'Failed to upload {new_file_name} to {bucket_name}. Keeping local file.')

bucket_name = "YOUR_BUCKET_NAME_HERE"  # Placeholder for bucket name
folder_path = "/home/ubuntu/livestream-archives"

upload_files_to_s3_and_remove(bucket_name, folder_path)