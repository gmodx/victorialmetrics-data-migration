# VictoriaMetrics Data Migration

## Environment

| Name    | Comments |
| -------- | ------- |
| REMOTE_VM_WRITE_ADDR | VictorialMetrics remote write address |

This project is used to migrate Prometheus data to a VictoriaMetrics cluster. It requires setting the REMOTE_VM_WRITE_ADDR environment variable to specify the write address of the target VictoriaMetrics cluster.

## Data Migration

### Prometheus to VictoriaMetrics

Run the following script to migrate Prometheus data to VictoriaMetrics:

``` shell
cd /app && ./start_prom_to_vm.sh
```
This script will export Prometheus data and write it to the VictoriaMetrics cluster.

### VictoriaMetrics Native to VictoriaMetrics Cluster

If you were previously using the VictoriaMetrics single-node version, you can run the following script to migrate the data to a VictoriaMetrics cluster:

``` shell
cd /app && ./start_vm_native_to_vm_cluster.sh
```

This script will export data from the VictoriaMetrics single-node version and write it to the VictoriaMetrics cluster.

## Docker

You can use the following Docker command to run the data migration container:

``` shell
docker run --rm \
--name=vm-data-migration \
-v /tmp/prometheus:/prometheus_data \
-v /tmp/vm_single_backup:/vm_data \
-p 0.0.0.0:2090:2090 \
-p 0.0.0.0:3090:3090 \
-e REMOTE_VM_WRITE_ADDR=http://10.12.210.25:30090 \
ghcr.io/gmodx/victorialmetrics-data-migration:latest
```

This command will mount the Prometheus and VictoriaMetrics single-node version data directories, and set the REMOTE_VM_WRITE_ADDR environment variable. After the container starts, it will automatically perform the data migration task.

## Kubernetes

You can also deploy the data migration task in a Kubernetes cluster. The [Yaml](./victorialmetrics-data-migration.yaml) file provides an example deployment configuration.

In summary, this project provides methods to migrate Prometheus data and VictoriaMetrics single-node version data to a VictoriaMetrics cluster. You can choose the appropriate method based on your actual situation to perform the data migration.