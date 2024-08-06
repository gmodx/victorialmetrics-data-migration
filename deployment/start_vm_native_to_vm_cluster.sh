#!/bin/bash

. ./scripts/lib_echo.sh

echo_green_bold "Start to run local vm-native service"
supervisorctl start vm-native

echo_green_bold "\nImporting vm-native to vm-cluster in background."
supervisorctl start vm-native-to-vm-cluster

echo_bold "Log file at /var/log/vm_native_to_vm_cluster.log\n"
tail -f /var/log/vm_native_to_vm_cluster.log