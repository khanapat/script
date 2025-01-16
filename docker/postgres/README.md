docker run --name postgresql -e POSTGRES_USER=usr -e POSTGRES_PASSWORD=P@ssw0rd -p 5432:5432 -d postgres

## docker

[image](https://hub.docker.com/_/postgres)

## initialization script

database will run any `*.sql` files, run any executable `*.sh` scripts in `/docker-entrypoint-initdb.d` folder.

scripts in `/docker-entrypoint-initdb.d` are only run if you start the container with a data directory that is empty.

## configuration

```bash
# get the default config
docker run -i --rm postgres:15 cat /usr/share/postgresql/postgresql.conf.sample > my-postgres.conf
```
