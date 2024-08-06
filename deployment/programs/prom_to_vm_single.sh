#!/bin/bash

BASEDIR=$(dirname $0)
. ${BASEDIR}/../scripts/lib_echo.sh

# create prometheus snapshot
echo_green_bold "Create Prometheus data snapshot"
response=$(curl -s -X POST "localhost:${INTERNAL_PROM_LISTEN_PORT}/api/v1/admin/tsdb/snapshot")
if [ $? -ne 0 ]; then
    echo_red "request failed"
    exit 1
fi

SNAPSHOT_NAME=$(echo "$response" | jq -r '.data.name')
SNAPSHOT_PATH="${INTERNAL_PROM_STORAGE_DIR}/snapshots/${SNAPSHOT_NAME}/"
echo -e "Prometheus snapshot path: $SNAPSHOT_PATH\n"

# import data to vm
echo_green_bold "Importing Prometheus data to VictoriaMetrics"
echo_and_run "vmctl prometheus -s --disable-progress-bar=true --vm-addr=\"$REMOTE_VM_ADDR\" --prom-snapshot=\"$SNAPSHOT_PATH\""

if [ $? -eq 0 ]; then
    echo_bold "\nData imported successfully."
    echo "Press Ctrl+C to exit."
else
    echo_red "\nFailed to import data."
    echo "Press Ctrl+C to exit."
    exit 1
fi