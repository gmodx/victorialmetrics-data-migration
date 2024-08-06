#!/bin/bash

exec prometheus \
--web.enable-lifecycle \
--query.lookback-delta=14s \
--query.max-samples=${INTERNAL_PROM_QUERY_MAX_SAMPLES} \
--storage.tsdb.allow-overlapping-blocks \
--config.file=/app/programs/prometheus.yml \
--storage.tsdb.path=${INTERNAL_PROM_STORAGE_DIR} \
--web.listen-address=":${INTERNAL_PROM_LISTEN_PORT}" \
--web.enable-admin-api \
--web.console.libraries=/usr/share/prometheus/console_libraries \
--web.console.templates=/usr/share/prometheus/consoles \
--storage.tsdb.retention.time=${INTERNAL_PROM_STORAGE_DAYS}d