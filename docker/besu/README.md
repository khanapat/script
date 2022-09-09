### Run

```sh
docker run -p <localportJSON-RPC>:8545 -p <localportWS>:8546 -p <localportP2P>:30303 hyperledger/besu:latest --rpc-http-enabled --rpc-ws-enabled

// example
docker run -p 8545:8545 -p 13001:30303 hyperledger/besu:latest --rpc-http-enabled
```

### Other

```sh
// generate extraData
besu rlp encode --from=toEncode.json

// export-address
besu --data-path=IBFT-Network/Node-5/data public-key export-address

```

### Ref

private key: https://besu.hyperledger.org/en/stable/public-networks/concepts/node-keys/#specify-a-custom-node-private-key-file

static node: https://besu.hyperledger.org/en/stable/public-networks/how-to/connect/static-nodes/
