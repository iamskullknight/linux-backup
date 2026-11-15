# Bash Backup Manager

A simple Linux backup tool written in Bash. It uses `rsync` to back up files, keep previous versions, and generate backup logs.

## Features

- **Automated backup:** Copies files using `rsync`.
- **File synchronization:** Keeps the backup folder updated with the source.
- **Version preservation:** Saves old versions of changed or deleted files.
- **Logging:** Creates separate backup and error logs.
- **Backup summary:** Shows file count, backup size, available storage, and backup status.

## Requirements

- Linux
- Bash
- rsync

Install rsync on Ubuntu:

```bash
sudo apt install rsync
```

## Project Structure

```text
bash-backup/
├── backup.sh
├── summary.sh
├── systemd/
├── README.md
└── .gitignore
```

## Setup

**1. Clone the repository**

```bash
git clone https://github.com/iamskullknight/linux-backup.git
cd linux-backup
```

**2. Configure your backup paths**

Open `backup.sh` and edit:

```bash
backup_src="/home/imp_files"
backup_mount="$HOME/backup-test"
```

- `backup_src`: Folder you want to back up.
- `backup_mount`: Where you want to store your backups.

**3. Make the scripts executable**

```bash
chmod +x backup.sh summary.sh
```

**4. Run a backup**

```bash
./backup.sh
```

**5. View the backup summary**

```bash
./summary.sh
```

## Backup Folder Structure

```text
backup-test/
├── current/
├── files_previous/
│   └── date/
└── logs/
    ├── backup_date.log
    └── backup_date_error.log
```

- `current/` – Latest backup.
- `files_previous/` – Older versions of changed or deleted files.
- `logs/` – Backup activity and error logs.

## Choosing a Backup Location

By default, backups are stored in `~/backup-test`. You can keep this location for testing or change it to another folder or an external drive.

### Option 1: Use a normal folder (default)

No changes are needed:

```bash
backup_mount="$HOME/backup-test"
require_mount=false
```

### Option 2: Use an external drive

1. Connect your external drive.
2. Find its mount point:

```bash
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT
```

3. Update the configuration in `backup.sh`:

```bash
drive_mount="/media/yourname/MyDrive"
backup_mount="$drive_mount/backup"
require_mount=true
```

The script will check that the external drive is mounted before starting the backup.

### Option 3: Use another folder

```bash
backup_mount="/data/backups/myfiles"
require_mount=false
```

### Important Notes

- This project is currently tested using a normal Ubuntu folder.
- The backup uses `rsync --delete`, so files deleted from the source are also removed from the current backup.
- Older versions of modified or deleted files are preserved in `files_previous`.
- Always test with unimportant files before backing up important data.
- Make sure the destination folder is writable.
- If using an external drive, connect it before running the backup.
- Update the backup paths in `summary.sh` if you change the destination.
- The script automatically creates the required backup folders and logs.


