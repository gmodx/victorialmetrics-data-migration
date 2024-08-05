#!/bin/bash

. ./scripts/lib_echo.sh

echo_green_bold "Start to run local prometheus service"
supervisorctl start prometheus

echo_green_bold "\nImporting Prometheus data to VictoriaMetrics(single) in background."
supervisorctl start prom-to-vm-single

echo_bold "Log file at /var/log/prom_to_vm_single.log\n"
tail -f /var/log/prom_to_vm_single.log