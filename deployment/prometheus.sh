#!/bin/bash

exec prometheus \
--web.enable-lifecycle \
--query.lookback-delta=14s \
--query.max-samples=${PROM_QUERY_MAX_SAMPLES} \
--storage.tsdb.allow-overlapping-blocks \
--config.file=/app/prometheus.yml \
--storage.tsdb.path=${PROM_STORAGE_DIR} \
--web.listen-address=":${PROM_LISTEN_PORT}" \
--storage.tsdb.retention.time=${PROM_STORAGE_DAYS}d