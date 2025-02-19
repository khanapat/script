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

## short syntax

> expose port `-p <local port>:<docker port>`

```yaml
ports:
    - 8080:80 # <local port>:<docker port>
```

## long syntax

```yaml
services:
    api:
        ports:
            - name: web
            target: 80 # docker port
            host_ip: 127.0.0.1
            published: 8080 # local port
            protocol: tcp
            app_protocol: http
            mode: host
```

[Reference](https://docs.docker.com/reference/compose-file/services/#ports)

# healthcheck

The healthcheck attribute declares a check that's run to determine whether or not the service containers are "healthy"

```yaml
services:
    api:
        healthcheck:
            # the first item must be either NONE, CMD or CMD-SHELL (/bin/sh for linux)
            test: ["CMD", "curl", "-f", "http://localhost"]
            interval: 1m30s
            timeout: 10s
            retries: 3
            start_period: 40s
            start_interval: 5s
```

> P.S. interval, timeout, start_period, and start_interval are specified as durations. Introduced in Docker Compose version 2.20.2

[Reference](https://docs.docker.com/reference/compose-file/services/#healthcheck)

# depends_on

With the depends_on attribute, you can control the order of service startup and shutdown. It is useful if services are closely coupled, and the startup sequence impacts the application's functionality.

## short syntax

```yaml
services:
    web:
        build: .
        # db and redis are created before web
        # web is removed before db and redis
        depends_on:
            - db
            - redis
    redis:
        image: redis
    db:
        image: postgres
```

## long syntax

```yaml
services:
    web:
        build: .
        depends_on:
            db:
                condition: service_healthy # service_started (created), service_healthy (be healthy "healthcheck"), service_completed_successfully (run completion)
                restart: true # restart after it updates the dependency service
            redis:
                condition: service_started
    redis:
        image: redis
    db:
        image: postgres
```

# links

links defines a network link to containers in another service. Either specify both the service name and a link alias (SERVICE:ALIAS), or just the service name.

```yaml
services:
    web:
        links:
            - db
            - db:database
            - redis
```

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
