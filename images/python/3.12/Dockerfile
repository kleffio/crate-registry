FROM ghcr.io/kleffio/images:base
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends python3.12 python3-pip \
  && rm -rf /var/lib/apt/lists/*
