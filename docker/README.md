# volume

1. bind mount (mount data in)

   > stored anywhere on the host system, can modify.

   - example
     ```bash
     docker run -d \
     --name=nginxtest \
     -v ${PWD}/nginx-vol:/usr/share/nginx/html \
     nginx:latest
     ```

2. volume (mount data out)

   > stored host filesystem managed by docker (/var/lib/docker/volumes/), should not modify (can't find with docker-desktop, only in vm)

   - example

     ```bash
     docker volume create nginx-vol

     docker run -d \
     --name=nginxtest \
     -v nginx-vol:/usr/share/nginx/html \
     nginx:latest
     ```

3. tmpfs mount

   > stored host system's memory only

> P.S. can't mount initial data out of container

# port

> expose port `-p <local port>:<docker port>`
