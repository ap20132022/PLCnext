#!/bin/bash

# Automatically determine the username
USER=$(logname)

# Find the mount point of the SD card (first under /media)
SD_PATH=$(find /media/$USER -mindepth 1 -maxdepth 1 -type d | head -n 1)

# Check if SD card is found
if [ -z "$SD_PATH" ]; then
    echo "❌ No SD card found under /media/$USER/"
    exit 1
fi

echo "📂 SD card detected at: $SD_PATH"

# Directory containing archive files
ARCHIVE_DIR="/home/$USER/Backups"

# List all .tar files in the archive directory
ARCHIVE_LIST=($(find "$ARCHIVE_DIR" -maxdepth 1 -type f -name "*.tar"))

# Check if any archives are found
if [ ${#ARCHIVE_LIST[@]} -eq 0 ]; then
    echo "❌ No .tar archive files found in $ARCHIVE_DIR"
    exit 1
fi

# Warning and confirmation
read -p "⚠️ All contents except '$SD_PATH/licence' will be deleted. Continue? (yes/no): " confirm
if [[ "$confirm" != "yes" ]]; then
    echo "❌ Operation cancelled."
    exit 1
fi

# Delete all contents except 'licence'
echo "🧹 Deleting all contents on the SD card except 'licence' ..."
find "$SD_PATH" -mindepth 1 -not -path "$SD_PATH/licence" -not -path "$SD_PATH/licence/*" -exec rm -rf {} +
echo "✅ Deletion complete. 'licence' folder was preserved."

# Show selection menu for archive files
echo "📦 Select an archive file to extract:"
select ARCHIVE_PATH in "${ARCHIVE_LIST[@]}"; do
    if [ -n "$ARCHIVE_PATH" ]; then
        echo "📂 Extracting $ARCHIVE_PATH to $SD_PATH ..."
        tar --same-owner -xvf "$ARCHIVE_PATH" -C "$SD_PATH" upperdir
        if [ $? -eq 0 ]; then
            echo "✅ Restore completed successfully."
        else
            echo "❌ Error during extraction."
        fi
        break
    else
        echo "❗ Invalid selection. Please try again."
    fi
done
