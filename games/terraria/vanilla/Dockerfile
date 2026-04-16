FROM ghcr.io/kleffio/images:base
ARG TERRARIA_VERSION=1.4.5.6
RUN TERRARIA_VER_NUM=$(echo $TERRARIA_VERSION | tr -d '.') \
  && mkdir -p /serverdata/Worlds \
  && cd /serverdata \
  && wget -q "https://terraria.org/api/download/pc-dedicated-server/terraria-server-${TERRARIA_VER_NUM}.zip" \
       -O terraria.zip \
  && unzip -q terraria.zip \
  && cp -R ${TERRARIA_VER_NUM}/Linux/* . \
  && chmod +x TerrariaServer.bin.x86_64 \
  && rm -rf terraria.zip ${TERRARIA_VER_NUM}
WORKDIR /serverdata
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
