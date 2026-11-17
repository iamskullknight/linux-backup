#!/usr/bin/env bash

backup_src="/home/imp_files"
backup_mount="$HOME/backup-test"
require_mount=false
drive_mount=""
backup_dest="$backup_mount/current"
current_date=$(date +%Y-%m-%d)
log_path="$backup_mount/logs"
previous_files="$backup_mount/files_previous/$current_date"

# safety check
if [ ! -d "$backup_src" ]; then
    echo "Source directory does not exist! Exiting!"
    exit 1
fi

if [ "$require_mount" = true ]; then
    if [ -z "$drive_mount" ] || ! mountpoint -q "$drive_mount"; then
        echo "Backup drive is not mounted! Exiting!"
        exit 1
    fi
fi

# Creating the necessary directories
mkdir -p "$log_path" "$previous_files" || {
    echo "Could not create backup directories! Exiting!"
    exit 1
}

# running rsync
rsync -av --delete --backup --backup-dir="$previous_files" "$backup_src" "$backup_dest" \
>"$log_path/backup_$current_date.log" 2> "$log_path/backup_${current_date}_error.log"

# Check rsync result
if [ $? -eq 0 ]; then
    echo "Backup completed successfully!"
else
    echo "Backup failed! Check the error log."
    exit 1
fi
