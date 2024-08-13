#!/bin/bash

BASEDIR=$(dirname $0)
. ${BASEDIR}/../scripts/lib_echo.sh

# check VM-Native is ready
echo_green_bold "Checking if VictorialMetrics(native) is ready..."
while true; do
    status_code=$(curl --write-out %{http_code} --silent --output /dev/null "localhost:${INTERNAL_VM_LISTEN_PORT}/-/ready")
    if [ "$status_code" -eq 200 ]; then
        echo_green "VictorialMetrics(native) is ready!\n"
        break
    else
        echo_yellow "VictorialMetrics(native) is not ready yet, waiting 5 seconds..."
        sleep 5
    fi
done

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