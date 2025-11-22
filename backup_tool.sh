

#!/bin/bash
# backup_tool.sh — automated file and directory backup tool

BACKUP_SRC="/mnt/e/bash project"
BACKUP_DIR="$HOME/Backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# create backup folder if not exists
mkdir -p "$BACKUP_DIR"

echo "🔄 Starting backup process..."
echo "Source: $BACKUP_SRC"
echo "Destination: $BACKUP_FILE"
echo "------------------------------------"

# create compressed archive
tar -czf "$BACKUP_FILE" "$BACKUP_SRC" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Backup completed successfully!"
    echo "File saved at: $BACKUP_FILE"
else
    echo "❌ Backup failed!"
    exit 1
fi

# optional: cleanup old backups older than 7 days
find "$BACKUP_DIR" -type f -mtime +7 -name "*.tar.gz" -exec rm {} \;
echo "🧹 Old backups (7+ days) cleaned up."
