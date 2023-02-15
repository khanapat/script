# eth-signer

-   https://docs.ethsigner.consensys.net/overview
-   https://hub.docker.com/r/consensys/ethsigner

## command

```bash
docker run -p <listenPort>:8545 -v <~/myKeyFile>:/opt/ethsigner/keyfile -v <~/myPasswordFile>:/opt/ethsigner/passwordfile consensys/ethsigner:latest --chain-id=2018 --downstream-http-host=<PantheonHost> --downstream-http-port=8590 --http-listen-host=0.0.0.0 file-based-signer -k /opt/ethsigner/keyfile -p /opt/ethsigner/passwordfile
```

## example

```bash
docker run -p 8545:8545 -v ./keyfile:/opt/ethsigner/keyfile -v ./passwordfile:/opt/ethsigner/passwordfile consensys/ethsigner:22.1 --chain-id=1337 --downstream-http-host=localhost --downstream-http-port=8590 --http-listen-host=0.0.0.0 file-based-signer -k /opt/ethsigner/keyfile -p /opt/ethsigner/passwordfile
```
