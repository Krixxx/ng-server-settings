#!/bin/bash

# Define variables
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR=~/backups
VOLUME_NAME=postgres_data

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Run backup container
docker run --rm -v $VOLUME_NAME:/volume -v $BACKUP_DIR:/backup ubuntu \
    tar czvf /backup/postgres_backup_$TIMESTAMP.tar.gz -C /volume .