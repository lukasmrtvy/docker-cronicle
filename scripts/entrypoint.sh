#!/bin/sh

export CRONICLE_foreground=1

if [ -n "${SETUP_CONFIG+x}" ]; then
        /opt/cronicle/bin/control.sh  setup
fi

exec "$@"
