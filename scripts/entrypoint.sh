#!/bin/sh

DATA_DIR=/opt/cronicle/data/

export CRONICLE_foreground=1
export CRONICLE_Storage__Filesystem__base_dir=$DATA_DIR
export CRONICLE_echo=${CRONICLE_echo:-1}

if [ ! "$(ls -A $DATA_DIR)" ]; then
    echo "$(date -I'seconds') INFO $DATA_DIR is empty, running setup ..."
    /opt/cronicle/bin/control.sh  setup
    echo "$(date -I'seconds') INFO done"
fi

exec "$@"
