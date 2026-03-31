#!/bin/sh

set -eu

set -- openconnect \
	--user="$VPN_USER" \
	--passwd-on-stdin \
	--non-inter \
	--csd-wrapper=/usr/libexec/openconnect/csd-wrapper.sh \
	--script-tun \
	--script "ocproxy -g -k 60 -D 9052" \
	--os=linux-64

if [ -n "${VPN_GROUP:-}" ]; then
	set -- "$@" --authgroup="$VPN_GROUP"
fi

set -- "$@" "$VPN_HOST"

printf '%s\n' "$VPN_PASSWORD" | "$@"
