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
echo "Getting GSE path to a latest dump gs://$BUCKET_NAME/$DB_NAME"
GSE_LATEST_DUMP=`/root/gsutil/gsutil ls gs://$BUCKET_NAME/$DB_NAME | tail -1` || exit
echo "Got GSE path to a latest dump $GSE_LATEST_DUMP"

# Copy the dump
mkdir -p $BACKUP_PATH || exit

echo "Started copying from GSE"

/root/gsutil/gsutil cp $GSE_LATEST_DUMP $BACKUP_PATH 2>&1 || exit

echo "Finished copying from GSE successfully"

# Extract the backup
cd $BACKUP_PATH || exit

BACKUP_FILE_NAME=`ls | tail -1` || exit

echo "Copied $BACKUP_FILE_NAME"

# Unpacking
echo "Unpacking $BACKUP_FILE_NAME"

tar -xvzf $BACKUP_FILE_NAME || exit

echo "Unpacked $BACKUP_FILE_NAME"

#restore

for DB in $DB_END_NAME
do

# Iteration start
echo "Started restoring a database DB_HOST: $DB_HOST; DB_PASS:$DB_PASS; DB_END_NAME: $DB;"

mongorestore -h "$DB_HOST" -u "$DB_USER" -p "$DB_PASS" -d "$DB" --drop "$DB_NAME" || exit

echo "Finished restoring"
done

rm -rf $BACKUP_PATH/*
cd /

echo "Removed backup data"