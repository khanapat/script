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

# dockerfile

1. RUN

-   execute during build process
-   each `RUN` creates a new layer in docker image
-   using `RUN` to install specific software or library
-   combining related commands into a single `RUN` instruction where possible to reduce image size

```sh
RUN apt update && apt -y install apache2
```

2. CMD

-   execute when a container is started from docker image
-   If no command is specified during the container startup, this default is used. (can be overridden by supplying command-line arguments to `docker run` .)

```sh
CMD ["apache2ctl", "-DFOREGROUND"]
# if using `docker run -it <image> /bin/bash`, container get bash shell instead of apache.
```

3. ENTRYPOINT

-   sets the default executable for the container. any arguments supplied are appended to the `ENTRYPOINT` command
-   using `ENTRYPOINT` when you need to always run the same base command, and you want to allow users to append additional commands at the end

```sh
ENTRYPOINT ["my_script"]
# if using `docker run -it <image> extra_args`, container run my_script with extra_args
```
