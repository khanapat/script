# geth with cli

- https://geth.ethereum.org/docs/getting-started
- https://ethereum.stackexchange.com/questions/66927/how-to-set-sealers-in-genesis-block-extradata-for-a-clique-poa-network

## install

```bash
brew install ethereum
```

## cli

```bash
# generate a new account
geth account new --keystore ./data/data-private/keystore

# init geth database
get init --datadir ./data/data-private ./genesis.json

# start geth connect with goerli
geth --datadir ./data/data-goerli --goerli --syncmode snap
# start geth connect with local
geth --datadir ./data/data-private --networkid 12345

# running member nodes
geth --datadir ./data/data2-private --networkid 12345 --port 30305 --bootnodes <bootstrap-node-record>

# interfact with geth
geth attach ./data/data-goerli/geth.ipc
```

## tutorial for private network

```bash
mkdir ./data/node1 ./data/node2

geth --datadir ./data/node1 account new
geth --datadir ./data/node2 account new

geth init --datadir ./data/node1 ./genesis.json
geth init --datadir ./data/node2 ./genesis.json

bootnode -genkey boot.key # gen key for bootnode
bootnode -nodekey boot.key -addr :30305 # run bootnode

geth --datadir ./data/node1 --port 30306 --bootnodes enode://c489b0ffb8e1da3c103e014394d0929bc6ffcc1c98adccaf78576ef9170ac791c3e432de35b43444ab7a14f75d42264e3f81f061d84b28c04febca42cd9c2cff@127.0.0.1:0\?discport\=30305 --networkid 12345 --unlock 0x0a4b986b3723269491faa735cbb2f3e73a044a23 --password ./data/node1/password.txt --mine

geth --datadir ./data/node2 --port 30307 --authrpc.port 8552 --bootnodes enode://c489b0ffb8e1da3c103e014394d0929bc6ffcc1c98adccaf78576ef9170ac791c3e432de35b43444ab7a14f75d42264e3f81f061d84b28c04febca42cd9c2cff@127.0.0.1:0\?discport\=30305 --networkid 12345 --unlock 0x002cd2511396bbb45830d56bc4137134e7392982 --password ./data/node1/password.txt --mine

geth attach ./data/node1/geth.ipc
geth attach ./data/node2/geth.ipc

personal.unlockAccount(eth.accounts[0])
eth.accounts
eth.getBalance("<address>")
eth.sendTransaction({to: "<address>", from: eth.accounts[0], value: 25000})
```
