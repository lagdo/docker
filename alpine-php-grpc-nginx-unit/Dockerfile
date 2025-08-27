ARG ALPINE_VERSION=3.22
ARG PHP_VERSION=8.4
ARG UNIT_VERSION=1.34.2
ARG PHP_ALPINE_VERSION=${PHP_VERSION}-zts-alpine${ALPINE_VERSION}

# Nginx Unit downloader
FROM alpine:${ALPINE_VERSION} AS nginx-unit-downloader

ARG UNIT_VERSION
WORKDIR "/tmp/unit"
ADD ["https://codeload.github.com/nginx/unit/tar.gz/refs/tags/${UNIT_VERSION}", "/tmp/unit.tar.gz"]
RUN tar zxvf /tmp/unit.tar.gz --strip=1 -C "/tmp/unit"

# Nginx Unit builder
ARG ALPINE_VERSION
FROM php:${PHP_ALPINE_VERSION} AS nginx-unit-builder

COPY --from=nginx-unit-downloader ["/tmp/unit", "/build/unit/"]
ENV DESTDIR=/opt/unit/
WORKDIR "/build/unit/"
ARG PHP_VERSION

RUN set -eux && \
  apk add --update --no-cache alpine-sdk openssl-dev pcre-dev pcre curl && \
  ./configure --log=/var/log/unitd.log && \
  ./configure php --module="php" && \
  make -j "$(nproc)" && \
  make -j "$(nproc)" install && \
  make clean

# Root builder
FROM lagdo/alpine-php-zts-grpc

RUN --mount=type=bind,from=mlocati/php-extension-installer:2,source=/usr/bin/install-php-extensions,target=/usr/local/bin/install-php-extensions \
  install-php-extensions opcache zip intl sockets bcmath ctype phar \
  curl dom fileinfo gd mbstring openssl redis tokenizer

# Nginx Unit
COPY --from=nginx-unit-builder ["/opt/unit/", "/opt/unit/"]
RUN cp -R /opt/unit/usr/local/* /usr/local

# Configure Nginx Unit
COPY ./entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
