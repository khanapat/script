besu \
--genesis-file=genesis.json \
--data-path=data/rpcnode \
--bootnodes=enode://05ecb64e480000d454bc3a7e9091cb7ca9cb6234063bc63a76081c95a0557a11e282251685034b5ec003f6aca8ef99466fed5118cc86fe8c8f6d3b8d2b046552@127.0.0.1:30303 \
--p2p-port=30304 \
--rpc-http-enabled \
--rpc-http-cors-origins=* \
--host-allowlist=*