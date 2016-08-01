#!/bin/bash
set -e

if [ "$1" = 'bitcoind' ]; then
	mkdir -p "$BITCOIN_DATA"

	if [ ! -s "$BITCOIN_DATA/bitcoin.conf" ]; then
    echo "printtoconsole=1" >> "$BITCOIN_DATA/bitcoin.conf"
    echo "rpcuser=bitcoinrpc" >> "$BITCOIN_DATA/bitcoin.conf"
    echo "rpcpassword=$(cat /dev/urandom | env LC_CTYPE=C tr -dc a-zA-Z0-9 | head -c45)" >> "$BITCOIN_DATA/bitcoin.conf"
	fi

	exec "$@" -server
fi

exec "$@"