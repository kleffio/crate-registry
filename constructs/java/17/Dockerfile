FROM ghcr.io/kleffio/constructs:base

USER root
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends openjdk-17-jre-headless jq \
  && rm -rf /var/lib/apt/lists/*

USER container
