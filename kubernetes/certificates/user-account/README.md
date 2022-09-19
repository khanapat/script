```sh
# create client key (private key)
openssl genrsa -out trust.key 2048

# create certificate signing request (cert)
openssl req -new -key trust.key -out trust.csr
openssl req -new -key trust.key -out user1.csr -subj "/CN=trust/O=dev"

# generate request in k8s script (submit-csr.yaml)
cat user1.csr | base64 | tr -d "\n"
```
