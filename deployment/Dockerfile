FROM victoriametrics/victoria-metrics:v1.101.0 as vm-img
FROM victoriametrics/vmctl:v1.101.0 as vmctl-img
FROM ubuntu:20.04

COPY --from=vm-img /victoria-metrics-prod /bin/victoria-metrics
COPY --from=vmctl-img /vmctl-prod /bin/vmctl

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

COPY --chown=${user}:${group} supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY --chown=${user}:${group} *.sh /app/