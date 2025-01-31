#!/bin/bash

# Files that must be deleted.
paths=(
    "~/Library/Cookies/com.docker.docker.binarycookies"
    "~/Library/Logs/Docker Desktop"
    "~/Library/Application Support/Docker Desktop"
    "~/Library/Caches/com.docker.docker"
    "~/Library/Group Containers/group.com.docker"
    "~/Library/Saved Application State/com.electron.docker-frontend.savedState"
    "/Library/PrivilegedHelperTools/com.docker.vmnetd"
    "/Library/LaunchDaemons/com.docker.vmnetd.plist"
    "/usr/local/lib/docker"
    "~/.docker"
)

# Loop to delete declared files.
for path in "${paths[@]}"; do
    eval rm -rf $path
    echo "Deleted: $path"
done

echo ""
echo "DONE."