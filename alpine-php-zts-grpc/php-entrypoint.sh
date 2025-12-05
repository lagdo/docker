#!/bin/sh
set -e

# Install Composer packages
/usr/local/bin/php-install.sh

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php "$@"
fi

exec "$@"
