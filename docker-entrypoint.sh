#!/bin/sh

# if only options are provided, then assume we want to execute curator directly
if [ "${1:0:1}" = '-' ]; then
	set -- curator "$@"
fi

exec "$@"
