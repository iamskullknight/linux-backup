#!/bin/bash

# Backup directory

backup_dir="$HOME/backup-test/current"

# Log file (change this to your actual log path)
log_file="$HOME/backup-test/logs/backup_$(date +%Y-%m-%d).log"

echo "╔════════════════════════════════════════╗"
echo "║          LINUX BACKUP SUMMARY          ║"
echo "╚════════════════════════════════════════╝"


# Check backup directory
if [ ! -d "$backup_dir" ]; then
    echo "Backup directory not found!"
    exit 1
fi

# File count
total_files=$(find "$backup_dir" -type f | wc -l)

# Backup size
backup_size=$(du -sh "$backup_dir" | cut -f1)

# Available storage
available_space=$(df -h "$backup_dir" | awk 'NR==2 {print $4}')

# Backup status
error_log="$HOME/backup-test/logs/backup_$(date +%Y-%m-%d)_error.log"

if [ ! -f "$log_file" ]; then
    backup_status="UNKNOWN"
elif [ -s "$error_log" ]; then
    backup_status="CHECK LOG"
else
    backup_status="SUCCESS"
fi

# Display summary
echo "Total Files       : $total_files"
echo "Backup Size       : $backup_size"
echo "Available Storage : $available_space"
echo "Backup Status     : $backup_status"

echo "================================"
