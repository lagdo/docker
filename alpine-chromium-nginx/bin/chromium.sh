#!/bin/sh

exec chpst -u chromium /usr/bin/chromium-browser --headless \
  --disable-gpu --no-sandbox \
  --disable-software-rasterizer \
  --disable-dev-shm-usage \
  --remote-debugging-port=9220 \
  --remote-allow-origins=http://127.0.0.1 \
  --user-data-dir=/data/chromium
