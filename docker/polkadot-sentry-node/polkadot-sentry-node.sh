#!/bin/bash

set -e
set -x

get_node_id() {
    node_id=$(cat /polkadot-node-ids/$1)
    printf '%s\n' "--sentry /dns4/$1.polkadot-private-node/tcp/30333/p2p/$node_id"
}

sentry_param=$(get_node_id "polkadot-private-node-0")

if [ -e /polkadot-node-keys/$(hostname) ]; then
    node_key_param="--node-key $(cat /polkadot-node-keys/$(hostname))"
fi

/usr/local/bin/polkadot --pruning=archive --wasm-execution Compiled \
         --unsafe-ws-external \
         --unsafe-rpc-external \
         --rpc-methods=Unsafe \
         --rpc-cors=all \
         --telemetry-url 'wss://telemetry-backend.w3f.community/submit 0' \
         $sentry_param $node_key_param