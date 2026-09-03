#!/bin/bash
set -euo pipefail

MOUNT_POINT="/Volumes/santhosh-restic"
SMB_HOST="blackhole.thewisefool.fyi"
SMB_SHARE="santhosh-restic"

is_mounted() {
  mount | grep -q "$MOUNT_POINT"
}

if is_mounted; then
  exit 0
fi

if mount_smbfs "//${SMB_HOST}/${SMB_SHARE}" "$MOUNT_POINT"; then
  exit 0
fi

# mount_smbfs can fail with "already mounted" on a race with the check above.
if is_mounted; then
  exit 0
fi

exit 1
