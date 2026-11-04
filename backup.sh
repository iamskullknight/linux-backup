#!/bin/bash

backup_src="/home/imp_files"
backup_dest="/mnt/backup/current"
current_date=$(date +%Y-%m-%d)
log_path="/mnt/backup/logs"
previous_files="/mnt/backup/files_previous/$current_date"

# Creating the nessary dir
mkdir -p "$log_path"
mkdir -p "$previous_files"

# running rsync
rsync -av --delete --backup --backup-dir="$previous_files" "$backup_src" "$backup_dest" \
>"$log_path/backup_$current_date.log" 2> "$log_path/backup_${current_date}_error.log"
