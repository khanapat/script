https://besu.hyperledger.org/en/stable/private-networks/tutorials/ibft/#steps

1. generate node keys and a genesis file

```sh
besu operator generate-blockchain-config --config-file=ibftConfigFile.json --to=networkFiles --private-key-file-name=key
```

2. start node 1

```sh
cd Node-1

besu --node-private-key-file=../networkFiles/keys/0x885fe74bd741b029e66e5eec328db3c913d15c21/key --data-path=data --genesis-file=../genesis.json --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all"
```

3. start node 2

- <Node-1 Enode URL> is enode://<key.pub>@<host>:<port>

```sh
cd Node-2

besu --node-private-key-file=../networkFiles/keys/0x4493a97680c96beb132c1202cb30f2b405f2cfa2/key --data-path=data --genesis-file=../genesis.json --bootnodes=<Node-1 Enode URL> --p2p-port=30304 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8546
```

4. start node 3

```sh
cd Node-3

besu --node-private-key-file=../networkFiles/keys/0xca20231a8becfb15632bf96ec4ef203ab926f5ef/key --data-path=data --genesis-file=../genesis.json --bootnodes=<Node-1 Enode URL> --p2p-port=30305 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8547
```

5. start node 4

```sh
cd Node-4

besu --node-private-key-file=../networkFiles/keys/0xe79471a51eadac7774e4e02fd1fe6192f7cf0fa9/key --data-path=data --genesis-file=../genesis.json --bootnodes=<Node-1 Enode URL> --p2p-port=30306 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8548
```

6. get validator

```sh
curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_getValidatorsByBlockNumber","params":["latest"], "id":1}' localhost:8545
```

7. get balance

```sh
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["<address>", "latest"],"id":53}' http://127.0.0.1:8545
```

8. propose adding validator

```sh
curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_proposeValidatorVote","params":["<node address>", true], "id":1}' http://127.0.0.1:8545
```

9. get txn by hash

```sh
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getTransactionByHash","params":["<txn hash>"],"id":53}' http://127.0.0.1:8545
```

10. get pending vote

```sh
curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_getPendingVotes","params":[], "id":1}' http://127.0.0.1:8545
```

- test without bootnodes & discovery (use static-node)

```sh
cd Node-1

besu --node-private-key-file=../networkFiles/keys/0x885fe74bd741b029e66e5eec328db3c913d15c21/key --data-path=data --genesis-file=../genesis.json --static-nodes-file=../static-nodes.json --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --discovery-enabled=false --logging=debug


cd Node-2

besu --node-private-key-file=../networkFiles/keys/0x4493a97680c96beb132c1202cb30f2b405f2cfa2/key  --data-path=data --genesis-file=../genesis.json --static-nodes-file=../static-nodes.json --p2p-port=30304 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8546 --discovery-enabled=false --logging=debug


cd Node-3

besu --node-private-key-file=../networkFiles/keys/0xca20231a8becfb15632bf96ec4ef203ab926f5ef/key --data-path=data --genesis-file=../genesis.json --static-nodes-file=../static-nodes.json --p2p-port=30305 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8547 --discovery-enabled=false --logging=debug



cd Node-4

besu --node-private-key-file=../networkFiles/keys/0xe79471a51eadac7774e4e02fd1fe6192f7cf0fa9/key --data-path=data --genesis-file=../genesis.json --static-nodes-file=../static-nodes.json --p2p-port=30306 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8548 --discovery-enabled=false --logging=debug


cd Node-5

besu --node-private-key-file=../networkFiles/keys/0xfa979be9cb0d89133f3263d2b675db684f4c82f8/key --data-path=data --genesis-file=../genesis.json --static-nodes-file=../static-nodes.json --p2p-port=30307 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8549 --discovery-enabled=false --logging=debug
```

- test with bootnodes

```sh
besu --node-private-key-file=../networkFiles/keys/0x885fe74bd741b029e66e5eec328db3c913d15c21/key --data-path=data --genesis-file=../genesis.json  --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all"

besu --node-private-key-file=../networkFiles/keys/0x4493a97680c96beb132c1202cb30f2b405f2cfa2/key --data-path=data --genesis-file=../genesis.json --bootnodes="enode://e90904a81db22ace9415e387ea523869e13b82ca9a251403b3857c682d5b049204f7b92a8dd858ed3e0a35d4c3165b4a903d56819976d0086936f33ba52518cf@127.0.0.1:30303" --p2p-port=30304 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8546

besu --node-private-key-file=../networkFiles/keys/0xca20231a8becfb15632bf96ec4ef203ab926f5ef/key --data-path=data --genesis-file=../genesis.json --bootnodes="enode://e90904a81db22ace9415e387ea523869e13b82ca9a251403b3857c682d5b049204f7b92a8dd858ed3e0a35d4c3165b4a903d56819976d0086936f33ba52518cf@127.0.0.1:30303" --p2p-port=30305 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8547

besu --node-private-key-file=../networkFiles/keys/0xe79471a51eadac7774e4e02fd1fe6192f7cf0fa9/key --data-path=data --genesis-file=../genesis.json --bootnodes="enode://e90904a81db22ace9415e387ea523869e13b82ca9a251403b3857c682d5b049204f7b92a8dd858ed3e0a35d4c3165b4a903d56819976d0086936f33ba52518cf@127.0.0.1:30303" --p2p-port=30306 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8548

besu --node-private-key-file=../networkFiles/keys/0xfa979be9cb0d89133f3263d2b675db684f4c82f8/key --data-path=data --genesis-file=../genesis.json --bootnodes="enode://e90904a81db22ace9415e387ea523869e13b82ca9a251403b3857c682d5b049204f7b92a8dd858ed3e0a35d4c3165b4a903d56819976d0086936f33ba52518cf@127.0.0.1:30303" --p2p-port=30307 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8549

curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_proposeValidatorVote","params":["0xfa979be9cb0d89133f3263d2b675db684f4c82f8", true], "id":1}' http://127.0.0.1:8545
```

- test with service hosts

```sh
besu --node-private-key-file=../networkFiles/keys/0x885fe74bd741b029e66e5eec328db3c913d15c21/key --data-path=data --genesis-file=../genesis.json  --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-host="0.0.0.0"

besu --node-private-key-file=../networkFiles/keys/0x4493a97680c96beb132c1202cb30f2b405f2cfa2/key --data-path=data --genesis-file=../genesis.json --bootnodes="enode://e90904a81db22ace9415e387ea523869e13b82ca9a251403b3857c682d5b049204f7b92a8dd858ed3e0a35d4c3165b4a903d56819976d0086936f33ba52518cf@127.0.0.1:30303" --p2p-port=30304 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8546 --rpc-http-host="0.0.0.0"

besu --node-private-key-file=../networkFiles/keys/0xca20231a8becfb15632bf96ec4ef203ab926f5ef/key --data-path=data --genesis-file=../genesis.json --bootnodes="enode://e90904a81db22ace9415e387ea523869e13b82ca9a251403b3857c682d5b049204f7b92a8dd858ed3e0a35d4c3165b4a903d56819976d0086936f33ba52518cf@127.0.0.1:30303" --p2p-port=30305 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8547 --rpc-http-host="0.0.0.0"

besu --node-private-key-file=../networkFiles/keys/0xe79471a51eadac7774e4e02fd1fe6192f7cf0fa9/key --data-path=data --genesis-file=../genesis.json --bootnodes="enode://e90904a81db22ace9415e387ea523869e13b82ca9a251403b3857c682d5b049204f7b92a8dd858ed3e0a35d4c3165b4a903d56819976d0086936f33ba52518cf@127.0.0.1:30303" --p2p-port=30306 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8548 --rpc-http-host="0.0.0.0"

besu --node-private-key-file=../networkFiles/keys/0xfa979be9cb0d89133f3263d2b675db684f4c82f8/key --data-path=data --genesis-file=../genesis.json --bootnodes="enode://e90904a81db22ace9415e387ea523869e13b82ca9a251403b3857c682d5b049204f7b92a8dd858ed3e0a35d4c3165b4a903d56819976d0086936f33ba52518cf@127.0.0.1:30303" --p2p-port=30307 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8549 --rpc-http-host="0.0.0.0"
```
