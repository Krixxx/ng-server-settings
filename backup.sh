#!/bin/bash

# Define variables
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR=~/backups
VOLUME_NAME=ng-server-settings_postgres_data
MAX_DAYS=1

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Run backup container
docker run --rm -v $VOLUME_NAME:/volume -v $BACKUP_DIR:/backup ubuntu \
    tar czvf /backup/postgres_backup_$TIMESTAMP.tar.gz -C /volume .

# Remove backups older than 30 days
# find $BACKUP_DIR -name "postgres_backup_*" -type f -mtime +$MAX_DAYS -exec rm {} \;

find $BACKUP_DIR -name "postgres_backup_*" -type f -mtime +$MAX_DAYS | while read file; do
    echo "Removing $file..."
    if [ -w "$file" ]; then
        rm "$file"
        echo "Removed $file."
    else
        echo "Skipping removal of $file because it's write-protected."
    fi
done