FROM ghcr.io/kleffio/images:base

LABEL org.opencontainers.image.source="https://github.com/kleffio/crate-registry"

ARG TERRARIA_VERSION=1.4.5.6

RUN adduser --disabled-password --gecos "" container \
  && TERRARIA_VER_NUM=$(echo $TERRARIA_VERSION | tr -d '.') \
  && mkdir -p /serverdata/Worlds \
  && cd /serverdata \
  && wget -q "https://terraria.org/api/download/pc-dedicated-server/terraria-server-${TERRARIA_VER_NUM}.zip" \
       -O terraria.zip \
  && unzip -q terraria.zip \
  && cp -R ${TERRARIA_VER_NUM}/Linux/* . \
  && chmod +x TerrariaServer.bin.x86_64 \
  && rm -rf terraria.zip ${TERRARIA_VER_NUM} \
  && chown -R container:container /serverdata

ENV USER=container HOME=/home/container
WORKDIR /serverdata
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER container
ENTRYPOINT ["/entrypoint.sh"]
