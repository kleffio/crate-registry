FROM debian:bookworm-slim
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
       ca-certificates curl wget unzip \
  && rm -rf /var/lib/apt/lists/*
