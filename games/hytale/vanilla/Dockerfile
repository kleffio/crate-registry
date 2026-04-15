FROM eclipse-temurin:25-jdk
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends curl unzip jq \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /data
