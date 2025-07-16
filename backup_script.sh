#!/bin/bash

# Automatically determine the username
USER=$(logname)

# Find the mount point of the SD card (first under /media)
SD_PATH=$(find /media/$USER -mindepth 1 -maxdepth 1 -type d | head -n 1)

# Name of the folder to back up on the SD card
FOLDER_NAME="upperdir"

# Destination directory for the backup
DEST="/home/$USER/Backups"

# Ensure the destination directory exists
mkdir -p "$DEST"

# Check if the folder exists
if [ -d "$SD_PATH/$FOLDER_NAME" ]; then
    read -p "Please enter a name for the backup file: " FILENAME
    BACKUP_NAME="${FILENAME}.tar"
    
    # Create the archive
    tar -cpf "$DEST/$BACKUP_NAME" -C "$SD_PATH" "$FOLDER_NAME"
    echo "✅ Backup successfully created: $DEST/$BACKUP_NAME"
else
    echo "❌ Folder '$FOLDER_NAME' not found on the SD card."
fi
