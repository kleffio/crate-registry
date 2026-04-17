FROM ghcr.io/kleffio/constructs:base

USER root
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends gnupg2 jq \
  && curl -fsSL https://packages.adoptium.net/artifactory/api/gpg/key/public \
     | gpg --dearmor -o /usr/share/keyrings/adoptium.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb bookworm main" \
     > /etc/apt/sources.list.d/adoptium.list \
  && apt-get update -qq \
  && apt-get install -y --no-install-recommends temurin-21-jre \
  && rm -rf /var/lib/apt/lists/*

USER container
