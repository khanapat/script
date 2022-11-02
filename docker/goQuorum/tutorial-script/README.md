# script

- https://consensys.net/docs/goquorum/en/latest/tutorials/private-network/create-ibft-network/

## install

```bash
# generate node keys for five nodes, static-nodes.json, permissioned-nodes.json, disallowed-nodes.json, and genesis.json
npx quorum-genesis-tool --consensus ibft --chainID 1337 --blockperiod 5 --requestTimeout 10 --epochLength 30000 --difficulty 1 --gasLimit '0xFFFFFF' --coinbase '0x0000000000000000000000000000000000000000' --validators 5 --members 0 --bootnodes 0 --outputPath 'artifacts'

# cp static-nodes.json and permissioned-nodes.json
cp artifacts/goQuorum/static-nodes.json artifacts/goQuorum/permissioned-nodes.json ./Node-0/data
cp artifacts/goQuorum/static-nodes.json artifacts/goQuorum/permissioned-nodes.json ./Node-1/data
cp artifacts/goQuorum/static-nodes.json artifacts/goQuorum/permissioned-nodes.json ./Node-2/data
cp artifacts/goQuorum/static-nodes.json artifacts/goQuorum/permissioned-nodes.json ./Node-3/data
cp artifacts/goQuorum/static-nodes.json artifacts/goQuorum/permissioned-nodes.json ./Node-4/data
```

## start

- istanbul is not available in http.api, ws.api
- istanbul.blockperiod is deprecated

```bash
export PATH=/Users/arise_user/Desktop/script/docker/goQuorum/tutorial-script/bin:$PATH

geth --datadir ./Node-0/data init ./genesis.json
geth --datadir ./Node-1/data init ./genesis.json
geth --datadir ./Node-2/data init ./genesis.json
geth --datadir ./Node-3/data init ./genesis.json
geth --datadir ./Node-4/data init ./genesis.json

# node-0
export ADDRESS=$(grep -o '"address": *"[^"]*"' ./Node-0/data/keystore/accountKeystore | grep -o '"[^"]*"$' | sed 's/"//g')
export PRIVATE_CONFIG=ignore
geth --datadir ./Node-0/data \
    --networkid 1337 --nodiscover --verbosity 5 \
    --syncmode full \
    --mine --miner.threads 1 --miner.gasprice 0 --emitcheckpoints \
    --http --http.addr 127.0.0.1 --http.port 22000 --http.corsdomain "*" --http.vhosts "*" \
    --ws --ws.addr 127.0.0.1 --ws.port 32000 --ws.origins "*" \
    --http.api admin,eth,debug,miner,net,txpool,personal,web3 \
    --ws.api admin,eth,debug,miner,net,txpool,personal,web3 \
    --unlock ${ADDRESS} --allow-insecure-unlock --password ./Node-0/data/keystore/accountPassword \
    --port 30300

# node-1
export ADDRESS=$(grep -o '"address": *"[^"]*"' ./Node-1/data/keystore/accountKeystore | grep -o '"[^"]*"$' | sed 's/"//g')
export PRIVATE_CONFIG=ignore
geth --datadir ./Node-1/data \
    --networkid 1337 --nodiscover --verbosity 5 \
    --syncmode full \
    --mine --miner.threads 1 --miner.gasprice 0 --emitcheckpoints \
    --http --http.addr 127.0.0.1 --http.port 22001 --http.corsdomain "*" --http.vhosts "*" \
    --ws --ws.addr 127.0.0.1 --ws.port 32001 --ws.origins "*" \
    --http.api admin,eth,debug,miner,net,txpool,personal,web3 \
    --ws.api admin,eth,debug,miner,net,txpool,personal,web3 \
    --unlock ${ADDRESS} --allow-insecure-unlock --password ./Node-1/data/keystore/accountPassword \
    --port 30301

# node-2
export ADDRESS=$(grep -o '"address": *"[^"]*"' ./Node-2/data/keystore/accountKeystore | grep -o '"[^"]*"$' | sed 's/"//g')
export PRIVATE_CONFIG=ignore
geth --datadir ./Node-2/data \
    --networkid 1337 --nodiscover --verbosity 5 \
    --syncmode full \
    --mine --miner.threads 1 --miner.gasprice 0 --emitcheckpoints \
    --http --http.addr 127.0.0.1 --http.port 22002 --http.corsdomain "*" --http.vhosts "*" \
    --ws --ws.addr 127.0.0.1 --ws.port 32002 --ws.origins "*" \
    --http.api admin,eth,debug,miner,net,txpool,personal,web3 \
    --ws.api admin,eth,debug,miner,net,txpool,personal,web3 \
    --unlock ${ADDRESS} --allow-insecure-unlock --password ./Node-2/data/keystore/accountPassword \
    --port 30302

# node-3
export ADDRESS=$(grep -o '"address": *"[^"]*"' ./Node-3/data/keystore/accountKeystore | grep -o '"[^"]*"$' | sed 's/"//g')
export PRIVATE_CONFIG=ignore
geth --datadir ./Node-3/data \
    --networkid 1337 --nodiscover --verbosity 5 \
    --syncmode full \
    --mine --miner.threads 1 --miner.gasprice 0 --emitcheckpoints \
    --http --http.addr 127.0.0.1 --http.port 22003 --http.corsdomain "*" --http.vhosts "*" \
    --ws --ws.addr 127.0.0.1 --ws.port 32003 --ws.origins "*" \
    --http.api admin,eth,debug,miner,net,txpool,personal,web3 \
    --ws.api admin,eth,debug,miner,net,txpool,personal,web3 \
    --unlock ${ADDRESS} --allow-insecure-unlock --password ./Node-3/data/keystore/accountPassword \
    --port 30303

# node-4
export ADDRESS=$(grep -o '"address": *"[^"]*"' ./Node-4/data/keystore/accountKeystore | grep -o '"[^"]*"$' | sed 's/"//g')
export PRIVATE_CONFIG=ignore
geth --datadir ./Node-4/data \
    --networkid 1337 --nodiscover --verbosity 5 \
    --syncmode full \
    --mine --miner.threads 1 --miner.gasprice 0 --emitcheckpoints \
    --http --http.addr 127.0.0.1 --http.port 22004 --http.corsdomain "*" --http.vhosts "*" \
    --ws --ws.addr 127.0.0.1 --ws.port 32004 --ws.origins "*" \
    --http.api admin,eth,debug,miner,net,txpool,personal,web3,istanbul \
    --ws.api admin,eth,debug,miner,net,txpool,personal,web3,istanbul \
    --unlock ${ADDRESS} --allow-insecure-unlock --password ./Node-4/data/keystore/accountPassword \
    --port 30304

# attach
geth attach ./Node-0/data/geth.ipc

net.peerCount
eth.accounts
eth.getBalance("<address>")
```

## ethereum keystore file (accountKeystore)

- https://julien-maffre.medium.com/what-is-an-ethereum-keystore-file-86c8c5917b97

```bash
# encrypting private key by `decryption key`
ciphertext(encrypted ethereum private key) + iv (initialisation vector) ==(aes-128-ctr with decryption key)==> decrypted ethereum private key

# protecting decryption key by `passphrase`
passphrase + kdfparams ==(kdf<scrypt>)==> decryption key

# checking passphrase
decryption key concat ciphertext(encrypted ethereum private key) ==(sha3-256)==> compared with mac (if mac == hash, valid)
```
