#!/bin/bash

backup_src="/home/imp_files"
backup_mount="$HOME/backup-test"
backup_dest="$backup_mount/current"
current_date=$(date +%Y-%m-%d)
log_path="$backup_mount/logs"
previous_files="$backup_mount/files_previous/$current_date"

# safety check
if [ ! -d "$backup_src" ]; then
    echo "Source directory does not exist! Exiting!"
    exit 1
fi

# Creating the nessary dir
mkdir -p "$log_path"
mkdir -p "$previous_files"

# running rsync
rsync -av --delete --backup --backup-dir="$previous_files" "$backup_src" "$backup_dest" \
>"$log_path/backup_$current_date.log" 2> "$log_path/backup_${current_date}_error.log"
