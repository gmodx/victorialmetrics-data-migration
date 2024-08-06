#!/bin/bash

BASEDIR=$(dirname $0)
. ${BASEDIR}/../scripts/lib_echo.sh

# # create prometheus snapshot
# echo_green_bold "Create vm-native data snapshot"
# response=$(curl -s -X POST "localhost:${INTERNAL_VM_LISTEN_PORT}/snapshot/create")
# if [ $? -ne 0 ]; then
#     echo_red "request failed"
#     exit 1
# fi

# echo "$response"
# SNAPSHOT_NAME=$(echo "$response" | jq -r '.snapshot')
# SNAPSHOT_PATH="${INTERNAL_VM_STORAGE_DIR}/snapshots/${SNAPSHOT_NAME}/"
# echo -e "vm-native snapshot path: $SNAPSHOT_PATH\n"

# import data to vm
echo_green_bold "Importing vm-native to vm-cluster"
START_TIME=$(date -d "-${REMOTE_VM_IMPORT_DAYS} days" -u +"%Y-%m-%dT%H:%M:%SZ")

echo_and_run "vmctl vm-native -s --disable-progress-bar=true \
--vm-native-src-addr=http://localhost:${INTERNAL_VM_LISTEN_PORT} \
--vm-native-dst-addr=${REMOTE_VM_WRITE_ADDR} \
--vm-native-filter-time-start='${START_TIME}' "

if [ $? -eq 0 ]; then
    echo_bold "\nData imported successfully."
    echo "Press Ctrl+C to exit."
    exit 0
else
    echo_red "\nFailed to import data."
    echo "Press Ctrl+C to exit."
    exit 1
fi