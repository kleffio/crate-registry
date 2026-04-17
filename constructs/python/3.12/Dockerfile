FROM ghcr.io/kleffio/constructs:base

USER root
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends python3 python3-pip \
  && rm -rf /var/lib/apt/lists/*

USER container
