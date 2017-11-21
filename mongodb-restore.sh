#!/bin/bash

# Settings
DB_HOST="$MONGO_HOST"
DB_NAME="$MONGO_DATABASE"
DB_END_NAME="$MONGO_END_DATABASE"
DB_USER="$MONGO_USER"
DB_PASS="$MONGO_PASS"
BUCKET_NAME="$BUCKET"

# Path in which copy a backup (will get cleaned later)
BACKUP_PATH="/mnt/data/dump"

# Get gce path to dumps
GSE_LATEST_DUMP=`/root/gsutil/gsutil ls gs://$BUCKET_NAME/$DB_NAME | tail -1`

# Copy the dump
mkdir -p $BACKUP_PATH

/root/gsutil/gsutil cp $GSE_LATEST_DUMP $BACKUP_PATH 2>&1 || exit

# Extract the backup
cd $BACKUP_PATH || exit

BACKUP_FILE_NAME=`ls | tail -1`

echo "Copied $BACKUP_FILE_NAME"

#unpuck
tar -xvzf $BACKUP_FILE_NAME

#restore
mongorestore -h "$DB_HOST" -u "$DB_USER" -p "$DB_PASS" -d "$DB_END_NAME" --drop "$DB_NAME"

echo "Restoring finished"

rm -rf $BACKUP_PATH/*
cd /

echo "Removed backup data"