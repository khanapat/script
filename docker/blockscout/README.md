# Blockscout

## Microservices

Services Include:

1. blockscout-ens - indexed data of doamin name service.
2. da-indexer - collects blobs from different DA solutions.
3. eth-bytecode-db - cross-chain smart-contracts database used for automatic contracts verification.
4. proxy-verifier - backend for the standalone multi-chain verification service.
5. sig-provider - aggregator of ethereum signatures for txns and events.
6. smart-contract-verifier - smart-contracts verification
7. stats - service designed to calculate and present statistical information.
8.

## Client Setting

    BlockScout currently supports _Geth_, _Erigon_, _Nethermind_, _Reth_, _Besu_, _RSKj_, _Lotus_, and _Ganache_ JSON RPC clients. To define the JSON RPC node variant, it's advised to define the `ETHEREUM_JSONRPC_VARIANT` environment variable.

# Run blockscout from docker image

```bash

```
