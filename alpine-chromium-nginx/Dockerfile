ARG ALPINE_VERSION=3.22
FROM alpine:${ALPINE_VERSION}

ENV NGINX_PORT=${NGINX_PORT:-9222}
ENV NGINX_ALLOW=${NGINX_ALLOW:-127.0.0.2}
ENV NGINX_DENY=${NGINX_DENY:-all}

# Installs latest Chromium package.
RUN apk upgrade --no-cache --available \
  && apk add --no-cache sed nginx supervisor \
    chromium chromium-swiftshader ttf-freefont font-noto-emoji font-montserrat \
  && apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community font-wqy-zenhei

ENV CHROMIUM_BIN=/usr/bin/chromium-browser CHROMIUM_PATH=/usr/lib/chromium/

# Configure a proxy in Nginx for Chrome
COPY ./config/nginx.conf /etc/nginx/http.d/chromium.conf

# Configure the fonts for Chrome
COPY ./config/local.conf.xml /etc/fonts/local.conf

# Configure Supervisord
COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./bin/chromium.sh /usr/local/bin/chromium.sh
COPY ./bin/nginx.sh /usr/local/bin/nginx.sh

RUN chmod +x /usr/local/bin/chromium.sh \
  && chmod +x /usr/local/bin/nginx.sh \
  # Add Chrome as a user
  && mkdir -p /data/chromium \
  && adduser -D chromium \
  && chown -R chromium:chromium /data/chromium \
    /etc/nginx/http.d/ /var/www /run /var/lib/nginx /var/log/nginx

# Run the container as non-privileged
USER chromium
WORKDIR /data/chromium

ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]
