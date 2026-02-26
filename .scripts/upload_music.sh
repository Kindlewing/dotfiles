#!/usr/bin/env bash
set -euo pipefail

# CONFIGURATION
MUSIC_DIR="$(cd "$(dirname "$0")" && pwd)"
LOCAL_DIR="$MUSIC_DIR/library"      # Local directory to sync
REMOTE_USER="hudson"                # Remote SSH user
REMOTE_HOST="192.168.2.124"        # Remote host IP or hostname
VOLUME_NAME="music"                 # Docker volume on remote host
REMOTE_STAGING="/tmp/${VOLUME_NAME}_staging"

# Clean up remote staging dir on exit (success or failure)
cleanup() {
    echo "Cleaning up remote staging dir..."
    ssh "$REMOTE_USER@$REMOTE_HOST" "rm -rf '$REMOTE_STAGING'" || true
}
trap cleanup EXIT

# Run beets pipeline
# fetchart, embedart, lyrics, lastgenre all run automatically during import (auto: yes)
echo "Importing new music..."
beet import -q "$MUSIC_DIR/to_be_tagged"

echo "Moving files to correct paths..."
beet move -q

# Validate local source exists
if [[ ! -d "$LOCAL_DIR" ]]; then
    echo "Error: LOCAL_DIR '$LOCAL_DIR' does not exist." >&2
    exit 1
fi

# Ensure Docker volume exists
echo "Ensuring Docker volume '$VOLUME_NAME' exists on $REMOTE_HOST..."
ssh "$REMOTE_USER@$REMOTE_HOST" \
    "docker volume inspect $VOLUME_NAME >/dev/null 2>&1 || docker volume create $VOLUME_NAME"

# Get volume mount path
REMOTE_VOL_PATH=$(ssh "$REMOTE_USER@$REMOTE_HOST" \
    "docker volume inspect --format '{{ .Mountpoint }}' $VOLUME_NAME")

# Sync local library -> remote staging (--delete propagates removes and moves)
echo "Syncing '$LOCAL_DIR' to remote staging..."
rsync -a --delete "$LOCAL_DIR"/ "$REMOTE_USER@$REMOTE_HOST:$REMOTE_STAGING/"

# Sync staging -> Docker volume using rsync inside the container
# --delete ensures files removed/moved out of the library are removed from the volume too
echo "Syncing from staging into Docker volume '$VOLUME_NAME'..."
ssh "$REMOTE_USER@$REMOTE_HOST" "
    docker run --rm \
        -v '$REMOTE_VOL_PATH':/data \
        -v '$REMOTE_STAGING':/source:ro \
        instrumentisto/rsync rsync -a --delete /source/ /data/
"

echo "Sync complete: '$LOCAL_DIR' -> Docker volume '$VOLUME_NAME' on $REMOTE_HOST"
