0. build dockerfile

```sh
docker build -t test-ubuntu:1.0.0 .
```

1. run with `CMD`

```sh
CMD ["ab"]

# arg behind container name is overridden CMD, that is why need to ab again then url.
docker run --rm test-ubuntu:1.0.0 https://jayschmidt.us
docker run --rm test-ubuntu:1.0.0 ab https://jayschmidt.us/
```

2. run with `ENTRYPOINT`

```sh
ENTRYPOINT ["ab"]

# entrypoint will be default at first command so url will append, that is why no need to repeat ab again.
docker run --rm  test-ubuntu:1.0.0 https://jayschmidt.us/
```
