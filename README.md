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
