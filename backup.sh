#!/bin/bash
BACKUP_DIR="/path/to/backups"
DB_NAME="your_database_name"
DB_USER="root"
DB_PASSWORD="your_password"
TIMESTAMP=$(date +"%F_%T")
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$TIMESTAMP.sql"

# Perform MySQL dump
mysqldump -u$DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_FILE

# Optionally upload to S3 or any remote storage
# aws s3 cp $BACKUP_FILE s3://your-bucket-name/
