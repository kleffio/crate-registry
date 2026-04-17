FROM debian:bookworm-slim

RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
       ca-certificates curl wget unzip \
  && rm -rf /var/lib/apt/lists/* \
  && adduser --disabled-password --gecos "" container \
  && mkdir -p /data \
  && chown container:container /data

ENV USER=container HOME=/home/container
WORKDIR /data

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER container
ENTRYPOINT ["/entrypoint.sh"]
