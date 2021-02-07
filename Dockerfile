FROM debian:latest
MAINTAINER Sergey Stepanenko

ENV TS_VERSION=1.1.77
ENV ARCH=linux-arm7

RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY *.crt /usr/local/share/ca-certificates/
RUN echo "Update root ca" \
    && update-ca-certificates

RUN mkdir -p /opt/torrserver/db && cd /opt/torrserver \
    && wget -O TorrServer "https://github.com/YouROK/TorrServer/releases/download/$TS_VERSION/TorrServer-$ARCH" \
    && chmod +x /opt/torrserver/TorrServer

VOLUME ["/opt/torrserver/db"]

ENTRYPOINT ["/opt/torrserver/TorrServer","--path", "/opt/torrserver/db"]
