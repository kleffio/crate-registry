FROM ghcr.io/kleffio/images:base
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends openjdk-21-jre-headless \
  && rm -rf /var/lib/apt/lists/*
