#!/usr/bin/env bash
set -euo pipefail

# CONFIGURATION
LOCAL_DIR="./library"               # Local directory to sync
REMOTE_USER="hudson"                  # Remote SSH user
REMOTE_HOST="192.168.2.124"        # Remote host IP or hostname
VOLUME_NAME="music"             # Docker volume on remote host

ssh "$REMOTE_USER@$REMOTE_HOST" "docker volume inspect $VOLUME_NAME >/dev/null 2>&1 || docker volume create $VOLUME_NAME"
REMOTE_VOL_PATH=$(ssh "$REMOTE_USER@$REMOTE_HOST" "docker volume inspect --format '{{ .Mountpoint }}' $VOLUME_NAME")
rsync -azv --progress "$LOCAL_DIR"/ "$REMOTE_USER@$REMOTE_HOST:/tmp/$VOLUME_NAME"
ssh "$REMOTE_USER@$REMOTE_HOST" "docker run --rm -v $REMOTE_VOL_PATH:/data -v /tmp/$VOLUME_NAME:/source alpine sh -c 'cp -r /source/* /data/'"
echo "✅ Sync complete! '$LOCAL_DIR' has been copied into Docker volume '$VOLUME_NAME' on $REMOTE_HOST."
