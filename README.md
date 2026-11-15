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

## Important Note

This project is currently tested using a normal Ubuntu folder.

The backup uses `rsync --delete`, so files deleted from the source are also removed from the current backup. Older copies are preserved in `files_previous/`.

Always test with unimportant files before backing up important data.



## Backing up to an external drive or another folder

By default, backups are stored in `~/backup-test`, which is inside your home folder. That is fine for testing, but a real backup should live on a different drive.

**1. Plug in your drive and find where it is mounted**

```bash
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT
```

Look for your drive's mount point, for example `/media/yourname/MyDrive` or `/mnt/backup`.

**2. Change `backup_mount` in `backup.sh`**

```bash
# Before
backup_mount="$HOME/backup-test"

# After (external drive)
backup_mount="/media/yourname/MyDrive/backup"

# After (any other folder)
backup_mount="/data/backups/myfiles"
```

The script creates `current/`, `files_previous/` and `logs/` inside this folder automatically.

**3. Run the backup**

```bash
./backup.sh
```

**Important notes**

- **Mount the drive first.** If the drive is not plugged in or mounted, the script will create that folder on your local disk instead, and your files will not be on the external drive. Check with `lsblk` or `ls /media/yourname/` before running. For scheduled backups, make sure the drive is connected at the scheduled time.
- **Use a Linux filesystem if you can (ext4).** Drives formatted as NTFS, exFAT or FAT32 do not keep Linux file permissions or symlinks, so `rsync -a` may print permission warnings. They still work for simple file backups, but ext4 is the best choice for a dedicated backup drive.
- **Update `summary.sh` too.** It has its own path, so change `backup_dir`, `log_file` and `error_log` to match your new location.
- **Make sure you have write permission** to the destination folder.
