#!/bin/bash

VICTORIA_METRICS_URL="http://localhost:8428"

echo "Importing Prometheus data to VictoriaMetrics..."

vmctl import \
    --prometheusDataDir="$INTERNAL_PROM_STORAGE_DIR" \
    --victoriaMetricsUrl="$REMOTE_VM_ADDR"

if [ $? -eq 0 ]; then
    echo "Data imported successfully."
else
    echo "Failed to import data."
    exit 1
fi
