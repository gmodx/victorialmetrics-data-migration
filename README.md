# victorialmetrics-data-migration

## env

| Name    | Comments |
| -------- | ------- |
| REMOTE_VM_WRITE_ADDR | VictorialMetrics remote write address |

## data migration

### prometheus to vm

``` shell
cd /app && ./start_prom_to_vm.sh
```

### vm-native to vm-cluster

``` shell
cd /app && ./start_vm_native_to_vm_cluster.sh
```

## docker

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

## k8s

[Yaml](./victorialmetrics-data-migration.yaml)