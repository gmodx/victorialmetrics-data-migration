FROM victoriametrics/victoria-metrics:v1.101.0 as vm-img
FROM victoriametrics/vmctl:v1.101.0 as vmctl-img
FROM prom/prometheus:v2.36.1 as prom-img
FROM ubuntu:20.04

COPY --from=vm-img /victoria-metrics-prod /bin/victoria-metrics
COPY --from=vmctl-img /vmctl-prod /bin/vmctl
COPY --from=prom-img /usr/share/prometheus/console_libraries/ /usr/share/prometheus/console_libraries/
COPY --from=prom-img /usr/share/prometheus/consoles/ /usr/share/prometheus/consoles/
COPY --from=prom-img /bin/prometheus /bin/prometheus

RUN apt update && \
    apt install -y \
    vim-tiny \
    busybox \
    iproute2 \
    iperf3 \
    net-tools \
    sysstat \
    wget \
    curl \
    tzdata \
    supervisor \
    && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/supervisor && chmod -R o+rw /var/log/supervisor && \
    mkdir -p /run && chmod -R o+rw /run && \
    mkdir -p /app && chmod -R o+rw /app

COPY *.yml /app/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY *.sh /app/

ENV PROM_STORAGE_DAYS=365
ENV PROM_QUERY_MAX_SAMPLES=50000000
ENV PROM_STORAGE_DIR=/prometheus_data
ENV PROM_LISTEN_PORT=2090

ENV VM_STORAGE_DAYS=365
ENV VM_QUERY_MAX_SAMPLES=50000000
ENV VM_MAX_CONCURRENT_REQUESTS=4
ENV VM_LISTEN_PORT=3090
ENV VM_STORAGE_DIR=/vm_data

ENTRYPOINT ["/usr/bin/supervisord"]