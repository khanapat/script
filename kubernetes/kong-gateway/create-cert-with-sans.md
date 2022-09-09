
## Make SANS config file
```bash
cat << EOF > san.cnf
subjectAltName = @alt_names
[alt_names]
DNS.1   = kong-internal.blockchain.ktb
DNS.2   = kong-proxy-ssl.kong-internal.svc
IP.1 = 100.127.165.8
IP.2 = 100.127.165.40
IP.3 = 100.127.165.35
IP.4 = 100.127.165.41
IP.5 = 100.127.165.62
IP.6 = 100.127.165.31
IP.7 = 100.127.165.17
IP.8 = 100.127.165.28
IP.9 = 100.127.165.22
EOF
```

IP.1 = 10.9.211.106
IP.2 = 10.9.211.107
IP.3 = 10.9.211.109

IP.1 = 100.127.165.8
IP.2 = 100.127.165.40
IP.3 = 100.127.165.35
IP.4 = 100.127.165.41
IP.5 = 100.127.165.62
IP.6 = 100.127.165.31
IP.7 = 100.127.165.17
IP.8 = 100.127.165.28
IP.9 = 100.127.165.22

## Generate Key
```bash
openssl genrsa -aes256 -passout pass:gsahdg -out server.pass.key 2048

openssl rsa -passin pass:gsahdg -in server.pass.key -out server.key

rm server.pass.key
```

## Generate CSR
```bash
openssl req -new -subj "/C=TH/L=Bangkok/ST=Bangkok/O=Krungthai/OU=IT Innovation Lab/CN=kong-internal.blockchain.ktb" -key server.key -out server.csr 
```

## Generate Certificate with SANS
```bash
openssl x509 -req -sha256 -days 3650 -in server.csr -signkey server.key -out server.crt -extfile san.cnf
```

or

```bash
openssl genrsa -out server.key 2048 

openssl req -new -subj "/C=TH/L=Bangkok/ST=Bangkok/O=Krungthai/OU=IT Innovation Lab/CN=crednet.blockchain.ktb" -key server.key -out server.csr  

openssl x509 -req -sha256 -days 3650 -in server.csr -signkey server.key.pem -out server.crt -extfile san.cnf
```

## Investigate certificate 
```bash
openssl x509 -noout -text -in server.crt
```