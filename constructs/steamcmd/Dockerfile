FROM ghcr.io/kleffio/constructs:base

USER root
RUN dpkg --add-architecture i386 \
  && apt-get update -qq \
  && apt-get install -y --no-install-recommends \
       lib32gcc-s1 \
       libstdc++6 \
       libsdl2-2.0-0 \
       libopenal1 \
       zlib1g \
       jq \
       unzip \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /home/container/steamcmd \
  && curl -fsSL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
       | tar -xz -C /home/container/steamcmd \
  && chmod +x /home/container/steamcmd/steamcmd.sh \
  && chown -R container:container /home/container/steamcmd

USER container
