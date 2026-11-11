# Bash Backup Manager

A Linux backup automation project built using Bash scripting and rsync.

## Overview

Bash Backup Manager aims to simplify file backups by automating file synchronization, maintaining previous versions and scheduling backup operations using systemd.

The project focuses on creating a practical and reliable backup solution for everyday Linux users.

## Features

- Automated file synchronization using rsync.
- Preservation of previous file versions.
- Backup mount-point safety checks.
- Separate logs for backup operations and errors.
- Scheduled backups using systemd services and timers.

## Technologies

- Bash – Automation and scripting.
- rsync – File synchronization.
- systemd – Backup scheduling and service management.
- Linux – Operating environment.
- Git – Version control.

## Project Structure

```text
bash-backup/
├── backup.sh
├── README.md
├── .gitignore
└── systemd/
    ├── backup.service
    └── backup.timer
```

## Future Improvements

- Backup compression.
- Integrity verification.
- File restoration.
- Configurable backup locations.
