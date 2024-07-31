#!/bin/bash

exec victoria-metrics \
-promscrape.config=/app/victorialmetrics.yml \
-promscrape.suppressScrapeErrors=true \
-promscrape.config.strictParse=false \
-storageDataPath=${VM_STORAGE_DIR} \
-httpListenAddr=:${VM_LISTEN_PORT} \
-dedup.minScrapeInterval=14s \
-search.maxConcurrentRequests=${VM_MAX_CONCURRENT_REQUESTS} \
-search.maxSamplesPerQuery=${VM_QUERY_MAX_SAMPLES} \
-search.maxQueueDuration=20s \
-search.logSlowQueryDuration=20s \
-search.maxUniqueTimeseries=300000000 \
-retentionPeriod=${VM_STORAGE_DAYS}d \
-memory.allowedPercent=85