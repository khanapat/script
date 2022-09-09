besu \
--genesis-file=genesis.json \
--data-path=data/testnode \
--bootnodes=enode://eaf01b1ebf6d6b944aab4feeb93bd90eeb91a6cf9ee7692c105e340f2bd1b8845dd279b534fbde3e5e4b2ace8a937f7d0bd37db2d14d2b0c573e461520a1d24b@10.140.208.15:30303 \
--p2p-port=30306 \
--rpc-http-enabled \
--rpc-http-cors-origins=* \
--host-allowlist=*
--miner-enabled \
--miner-coinbase=0xc083EB69aa7215f4AFa7a22dcbfCC1a33999371C