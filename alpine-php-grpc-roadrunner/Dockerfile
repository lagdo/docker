FROM ghcr.io/roadrunner-server/roadrunner:2025 AS roadrunner
FROM lagdo/alpine-php-grpc

RUN --mount=type=bind,from=mlocati/php-extension-installer:2,source=/usr/bin/install-php-extensions,target=/usr/local/bin/install-php-extensions \
  install-php-extensions opcache zip intl sockets bcmath ctype phar \
  curl dom fileinfo gd mbstring openssl redis tokenizer

# RoadRunner
COPY --from=roadrunner /usr/bin/rr /usr/local/bin/rr
