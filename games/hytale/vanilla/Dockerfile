FROM eclipse-temurin:25-jdk

LABEL org.opencontainers.image.source="https://github.com/kleffio/crate-registry"

RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends curl unzip jq \
  && rm -rf /var/lib/apt/lists/* \
  && adduser --disabled-password --gecos "" container \
  && mkdir -p /data \
  && chown -R container:container /data

ENV USER=container HOME=/home/container
WORKDIR /data
USER container
