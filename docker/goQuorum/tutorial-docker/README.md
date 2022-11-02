# tutorial-docker

- https://medium.com/cladular/running-quorum-in-a-single-docker-container-configuration-fa1cc3552e48
- https://hub.docker.com/r/quorumengineering/quorum/tags
- https://blog.logrocket.com/docker-volumes-vs-bind-mounts/ (volume vs mount)

## install

```bash
# docker tool
# volume - mount data out | bind - mount data in
docker run --rm -it --name quorum-cli -v ${PWD}/tmp:/tmp --entrypoint sh quorumengineering/quorum:latest

bootnode --genkey=./tmp/nodekey

bootnode --nodekey=./tmp/nodekey --writeaddress
```
