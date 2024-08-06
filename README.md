# victorialmetrics-data-migration


```
docker run --rm \
--name=vm-data-migration \
-v /root/prometheus_data:/prometheus_data \
-p 0.0.0.0:2090:2090 \
-p 0.0.0.0:3090:3090 \
-e REMOTE_VM_WRITE_ADDR=http://10.12.210.25:30090 \
ghcr.io/gmodx/victorialmetrics-data-migration:latest
```
