#!/bin/bash

. ./scripts/lib_echo.sh

## backup old log file
if [ -f "/var/log/prom_to_vm_single.log" ]; then
    timestamp=$(date +"%Y%m%d_%H%M%S")
    mv /var/log/prom_to_vm_single.log /var/log/prom_to_vm_single_$timestamp.log
fi

echo_green_bold "Start to run local prometheus service"
supervisorctl start prometheus

echo_green_bold "\nImporting Prometheus data to VictoriaMetrics in background."
supervisorctl start prom-to-vm-single

echo_bold "Log file at /var/log/prom_to_vm_single.log\n"
tail -f /var/log/prom_to_vm_single.log