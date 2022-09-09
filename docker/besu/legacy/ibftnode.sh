besu \
--genesis-file=genesis_ibft.json \
--data-path=data/ibftnode \
--bootnodes=enode://621950a27a1f8eae349069ed6f6bf69da4bf0c001197d4176bebc389dcabd499f58bf95c40001048938579874d03b690ca53d3b3994d674edcb75b9e1748c45a@10.140.208.42:30303 \
--p2p-port=30304 \
--rpc-http-enabled \
--rpc-http-cors-origins=* \
--host-allowlist=*