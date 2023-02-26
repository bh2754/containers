FROM ghcr.io/bh2754/ubuntu:jammy-20230126@sha256:a1e5bc2f33d75973bf0f69d530935835125d15aa27464b492e117eae7889b326

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION
ARG CHANNEL
ARG UNRAR_VERSION=6.1.7

ENV \
    LAZYLIBRARIAN__INSTANCE_NAME="LazyLibrarian" \
    LAZYLIBRARIAN__BRANCH="${CHANNEL}" \
    LAZYLIBRARIAN__PORT="5299" \
    LAZYLIBRARIAN__ANALYTICS_ENABLED="False"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
    apt-get -qq update \
    && apt-get -qq install -y \
        libjpeg-turbo8-dev \
        python3-pip \
        zlib1g-dev \
        ghostscript \
        libjpeg-turbo8 \
        libmagic1 \
        python3-minimal \
        python3-openssl \
        zlib1g \
        unrar \
        crudini

RUN \
    mkdir -p /app/lazylibrarian \
    && \
    mkdir -p /defaults \
    && \
    printf "%s\n" "${VERSION}" > /defaults/version.txt

RUN \
    curl -o \
        /tmp/lazylibrarian.tar.gz -L \
        "https://gitlab.com/LazyLibrarian/LazyLibrarian/-/archive/{$VERSION}/LazyLibrarian-{$VERSION}.tar.gz" \
    && \
    tar xf /tmp/lazylibrarian.tar.gz -C /app/lazylibrarian --strip-components=1 \
    && \
    cd /app/lazylibrarian

RUN \
    pip3 install -U --no-cache-dir \
        charset-normalizer \
        idna \
        certifi \
        beautifulsoup4 \
        soupsieve \
        levenshtein \
        apprise \
        urllib3

RUN \
    apt-get -y purge \
        libjpeg-turbo8-dev \
        python3-pip \
        zlib1g-dev \
        && \
    apt-get -y autoremove \
    && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /root/.cache \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc

USER kah

COPY ./apps/lazylibrarian/config.ini.tmpl /defaults/config.ini
COPY ./apps/lazylibrarian/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://gitlab.com/LazyLibrarian/LazyLibrarian"
