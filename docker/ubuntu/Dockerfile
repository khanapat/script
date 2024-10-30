FROM ubuntu:20.04

RUN <<EOF
apt-get update;
apt-get install -y apache2-utils;
rm -rf /var/lib/apt/lists/*;
EOF

ENTRYPOINT ["ab"]