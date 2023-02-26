#!/usr/bin/env bash

#shellcheck disable=SC1091
test -f "/scripts/umask.sh" && source "/scripts/umask.sh"

# Create configuration if not present
if ! [[ -f /config/config.ini ]]; then
    envsubst < /defaults/config.ini.tmpl > /config/config.ini
fi

mkdir -p /config/cache
cp -f /defaults/version.txt /config/cache/version.txt

# Override configuration with environment settings
[[ -n "${LAZYLIBRARIAN__LOG_DIR}" ]] && crudini --set /config/config.ini General logdir ${LAZYLIBRARIAN__LOG_DIR}
[[ -n "${LAZYLIBRARIAN__LOG_LEVEL}" ]] && crudini --set /config/config.ini General loglevel ${LAZYLIBRARIAN__LOG_LEVEL}
[[ -n "${LAZYLIBRARIAN__DATA_DIR}" ]] && crudini --set /config/config.ini General destination_dir ${LAZYLIBRARIAN__DATA_DIR}
[[ -n "${LAZYLIBRARIAN__API_KEY}" ]] && crudini --set /config/config.ini General api_key ${LAZYLIBRARIAN__API_KEY}


#shellcheck disable=SC2086
exec \
    python3 /app/lazylibrarian/LazyLibrarian.py \
        --config /config/config.ini \
        --datadir /config
