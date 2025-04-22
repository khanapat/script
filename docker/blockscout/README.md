# Blockscout

## What can I do with Blockscout?

-   **Deep Search** : find all the information you need on Blocks, Transactions, more.
-   **Interact with Contract** : read and write to contracts directly from the blockscout UI.
-   **Verify Contracts** : Use Hardhat, Sourcify, and other tools to verify contracts.

ref: [LINK](https://docs.blockscout.com/about/features)

## Client Setting

    BlockScout currently supports _Geth_, _Erigon_, _Nethermind_, _Reth_, _Besu_, _RSKj_, _Lotus_, and _Ganache_ JSON RPC clients. To define the JSON RPC node variant, it's advised to define the `ETHEREUM_JSONRPC_VARIANT` environment variable.

ref: [LINK](https://docs.blockscout.com/setup/requirements/client-settings)

## Run blockscout from docker image

Blockscout supports several modes which run in a single all-in-one application by default.

```bash
cd ./docker-compose
docker compose up
```

### Modes

-   [Indexer](https://docs.blockscout.com/setup/information-and-settings/separate-indexer-web-app-and-api#indexer-mode)
-   [Web UI](https://docs.blockscout.com/setup/information-and-settings/separate-indexer-web-app-and-api#web-application-mode)
-   [API](https://docs.blockscout.com/setup/information-and-settings/separate-indexer-web-app-and-api#api-mode)
-   All-in-one (default)

<ins>combination</ins>

`indexer mode + API` to create an indexed db with programmatic access

`indexer mode + UI` to leverage Blockscout as read-only explorer

### Services

1. blockscout-ens - indexed data of domain name service for blockscout instances.

2. da-indexer - collects blobs from different DA solutions (e.g, Celestia)

3. eth-bytecode-db - Ethereum Bytecode Database. Cross-chain smart-contracts database used for automatic contracts verification

4. proxy-verifier - backend for the standalone multi-chain verification service

5. sig-provider - aggregator of ethereum signatures for transactions and events

6. smart-contract-verifier - smart-contracts verification

7. stats - service designed to calculate and present statistical information from a Blockscout instance

8. user-ops-indexer - service designed to index, decode and serve user operations as per the ERC-4337 standard

9. visualizer - service for evm visualization such as:
    1. Solidity contract visualization using [sol2uml](https://www.npmjs.com/package/sol2uml)

## Configuration

1. SECRET_KEY_BASE

go to [blockscout repo](https://github.com/blockscout/blockscout), clone this project and run the commandline below.

```sh
# install dependency
mix deps.get

# generate secret
mix phx.gen.secret
```

## Feature

1. Verify Smart Contract Code

    [Exact vs Partial Match](https://github.com/orgs/blockscout/discussions/10422)
    [Remix](https://docs.kcc.io/developers/verify-smart-contract/using-remix)

-   Exact Match (Code,Compiler,ABI,ByteCode) : using Standard JSON input

-   Partial Match (Code,ABI,ByteCode) : using Single, Multi file
