ARG ALPINE_VERSION=3.22
ARG PHP_VERSION=8.4
ARG PROTOBUF_VERSION=4.32.0

FROM php:${PHP_VERSION}-zts-alpine

ARG PROTOBUF_VERSION
RUN set -xe && \
  apk add --no-cache git autoconf libzip-dev freetype-dev icu-dev \
  libmcrypt-dev libxslt-dev pcre-dev pcre grpc-cpp grpc-dev $PHPIZE_DEPS && \
  pecl install protobuf-${PROTOBUF_VERSION} && \
  GRPC_VERSION=$(apk info grpc -d | grep grpc | cut -d- -f2) && \
  git clone --depth 1 -b v${GRPC_VERSION} https://github.com/grpc/grpc /tmp/grpc && \
  cd /tmp/grpc/src/php/ext/grpc && \
  phpize && \
  ./configure && \
  make && \
  make install && \
  rm -rf /tmp/grpc && \
  apk del --no-cache autoconf grpc-dev git $PHPIZE_DEPS && \
  echo "extension=grpc.so" > /usr/local/etc/php/conf.d/grpc.ini
