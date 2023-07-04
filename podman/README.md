```bash
#  start
podman machine init # start stop

# image
podman image search (podman search)
podman image pull (podman pull)
podman image ls (podman images)
podman image rm (podman rmi)
podman image build (podman build)
podman image prune # remove dangling images (cache)

# container
podman container ls (podman ps)
podman container run (podman run)
podman container rm (podman rm)
```

```bash
# hello
podman build -t <name>:<tag> .
podman run -it --rm --name=<name> --tz="Asia/Bangkok" <name>:<tag>

# api
podman run -dt --rm --name=<name> --tz="Asia/Bangkok" -p <host's port>:<container's port> <name>:<tag>

# repo
podman login docker.io
podman-compose up -d
podman-compose down
```

### reference

-   https://github.com/codebangkok/podman
