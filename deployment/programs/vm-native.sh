#!/bin/bash

exec victoria-metrics \
-promscrape.config=/app/programs/vm-native.yml \
-promscrape.suppressScrapeErrors=true \
-promscrape.config.strictParse=false \
-storageDataPath=${INTERNAL_VM_STORAGE_DIR} \
-httpListenAddr=:${INTERNAL_VM_LISTEN_PORT} \
-dedup.minScrapeInterval=14s \
-search.maxConcurrentRequests=${INTERNAL_VM_MAX_CONCURRENT_REQUESTS} \
-search.maxSamplesPerQuery=${INTERNAL_VM_QUERY_MAX_SAMPLES} \
-search.maxQueueDuration=20s \
-search.logSlowQueryDuration=20s \
-search.maxUniqueTimeseries=300000000 \
-retentionPeriod=${INTERNAL_VM_STORAGE_DAYS}d \
-memory.allowedPercent=85