FROM ubuntu:18.04

LABEL maintainer="sami.volotinen@gmail.com"

RUN rm -rf /var/lib/apt/lists/* && apt-get clean && apt-get update && apt-get install -y apt-transport-https && apt-get upgrade -y \
  && apt-get install zip -y \
  && apt-get install -y --no-install-recommends curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

ENV JAVA_VERSION jdk8u202-b08

RUN set -eux; \
  ARCH="$(dpkg --print-architecture)"; \
  case "${ARCH}" in \
  ppc64el|ppc64le) \
  ESUM='485533573e0a6aa4188a9adb336d24e795f9de8c59499d5b88a651b263fa1c34'; \
  BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u202-b08/OpenJDK8U-jdk_ppc64le_linux_hotspot_8u202b08.tar.gz'; \
  ;; \
  s390x) \
  ESUM='d47b6cfcf974e50363635bfc7c989b25b4681cd29286ba5ed426cfd486b65c5f'; \
  BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u202-b08/OpenJDK8U-jdk_s390x_linux_hotspot_8u202b08.tar.gz'; \
  ;; \
  amd64|x86_64) \
  ESUM='f5a1c9836beb3ca933ec3b1d39568ecbb68bd7e7ca6a9989a21ff16a74d910ab'; \
  BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u202-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u202b08.tar.gz'; \
  ;; \
  aarch64|arm64) \
  ESUM='8eee0aede947b804f9a5f49c8a38b52aace8a30a9ebd9383b7d06042fb5a237c'; \
  BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u191-b12/OpenJDK8U-jdk_aarch64_linux_hotspot_8u191b12.tar.gz'; \
  ;; \
  *) \
  echo "Unsupported arch: ${ARCH}"; \
  exit 1; \
  ;; \
  esac; \
  curl -Lso /tmp/openjdk.tar.gz ${BINARY_URL}; \
  sha256sum /tmp/openjdk.tar.gz; \
  mkdir -p /opt/java/openjdk; \
  cd /opt/java/openjdk; \
  echo "${ESUM}  /tmp/openjdk.tar.gz" | sha256sum -c -; \
  tar -xf /tmp/openjdk.tar.gz; \
  jdir=$(dirname $(dirname $(find /opt/java/openjdk -name javac))); \
  mv ${jdir}/* /opt/java/openjdk; \
  rm -rf ${jdir} /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk \
  PATH="/opt/java/openjdk/bin:$PATH"
ENV JAVA_TOOL_OPTIONS="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"
