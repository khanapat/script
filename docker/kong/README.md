# Kong Gateway

Kong Gateway is a lightweight, fast, and flexible cloud-native API gateway. An API gateway is a reverse proxy that lets you manage, configure, and route requests to your APIs.

Kong Gateway runs in front of any RESTful API and can be extended through modules and plugins. It’s designed to run on decentralized architectures, including hybrid-cloud and multi-cloud deployments.

## Component

1. Services

    Service is an entity representing an external upstream API or microservice. The main attribute of a service is its `URL`.

    Service represents the backend API.

2. Routes

    Route determines how requests are sent to thier services after they reach Kong Gateway. A route defines what is exposed to clients.

    A single service can have many routes.

    ```mermaid
    flowchart LR

    A(API client)
    B("`Route
    (/mock)`")
    C("`Service
    (example_service)`")
    D(Upstream
    application)

    A <--requests
    responses--> B
    subgraph id1 ["`**KONG GATEWAY**`"]
    B <--requests
    responses--> C
    end
    C <--requests
    responses--> D

    style id1 rx:10,ry:10
    ```

3. Cosumers

    Consumer refers to an entity that consumes or uses the APIs managed by Kong Gateway. Consumers can be applications, services, or users who interact with your APIs.

    Consumer are essential for **controlling access to your APIs, tracking usage, and ensuring security**. They are identified by **key authentication, OAuth, or other mechanisms**.

    Usecase: Authentication, Consumer groups, Rate limiting

    ```mermaid
    flowchart LR

    A(Consumer entity)
    B(Auth plugin)
    C[Upstream service]

    Client --> A
    subgraph id1[Kong Gateway]
        direction LR
        A--Credentials-->B
    end
    B-->C
    ```

4. Upstreams

    Upstream refers to an API, application, or micro-service that Kong Gateway forwards requests to. An upstream object represents a virtual hostname and can be used to health check, circuit break, and load balance incoming requests over multiple services.

5. Plugins

    Plugin provide advanced functionality and extend the use of the Kong Gateway.

    Scoping plugins: Services, Routes, Consumers and Consumer groups

6. Consumer Groups

    Consumer group enables the organization and categorization of consumers (users or applications) within an API ecosystem.

## Mode

1. With a database: Use a database to store Kong entity configurations, can use the Admin API.

2. Without a database (DB-less mode): Store Kong configuration in-memory on the node, the Admin API is read only.

## Deploy

db: kong database (postgres)

-   Postgres - port: 5432

kong: kong gateway

-   http Gateway - port: 8000
-   https Gateway - port: 8443
-   http Admin - port: 8001
-   https Admin - port: 8444
-   http GUI - port: 8002
-   https GUI - port: 8445

[Reference](https://docs.konghq.com/gateway/latest/production/networking/default-ports/)

### 0. get configuration

```bash
docker run -i --rm kong/kong-gateway:3.10.0.1 cat /etc/kong/kong.conf.default > kong.conf
```

### 1. start kong using docker

```bash
make kong-db-up
```

### 2. verify kong gateway status

```bash
curl -i http://localhost:8001
```

### 3. create service

To add a new service, send a `POST` request to Kong Gateway's Admin API `/services` route

```bash
curl -i -s -X POST http://localhost:8001/services \
--header 'Content-Type: application/json' \
--data '
    {
        "name": "my-pokemon-service",
        "retries": 5,
        "protocol": "https",
        "host": "pokeapi.co",
        "port": 443,
        "path": "/",
        "connect_timeout": 6000,
        "write_timeout": 6000,
        "read_timeout": 6000,
        "tags": [
            "user-level"
        ],
        "enabled": true
    }
'
```

```bash
curl -i -s -X POST http://localhost:8001/services \
--header 'Content-Type: application/json' \
--data '
    {
        "name": "my-user-service",
        "retries": 5,
        "protocol": "https",
        "host": "jsonplaceholder.typicode.com",
        "port": 443,
        "path": "/",
        "connect_timeout": 6000,
        "write_timeout": 6000,
        "read_timeout": 6000,
        "tags": [
            "user-level"
        ],
        "enabled": true
    }
'
```

[Reference](https://docs.konghq.com/gateway/api/admin-ee/latest/#/operations/create-service)

To List all services

```bash
curl -i -s -X GET http://localhost:8001/services
```

[Reference](https://docs.konghq.com/gateway/api/admin-ee/latest/#/operations/list-service)

### 4. create route

Routes define how requests are proxied by Kong Gateway. To create a route associated with a specific service by sending a `POST` request to the service URL.

Configure a new route on the `/mock` path to direct traffic to the `service` service created earlier

```bash
curl -i -X POST http://localhost:8001/services/my-pokemon-service/routes \
--header 'Content-Type: application/json' \
--data '
    {
        "name": "my-pokemon-service-route",
        "protocols": [
            "http",
            "https"
        ],
        "methods": [
            "GET",
            "POST"
        ],
        "paths": [
            "/api/v2/pokemon",
            "/api/v2/berry"
        ],
        "https_redirect_status_code": 426,
        "regex_priority": 0,
        "strip_path": false,
        "path_handling": "v0",
        "preserve_host": false,
        "request_buffering": true,
        "response_buffering": true,
        "tags": [
            "user-level"
        ]
    }
'
```

```bash
curl -i -X POST http://localhost:8001/services/my-user-service/routes \
--header 'Content-Type: application/json' \
--data '
    {
        "name": "my-user-service-route",
        "protocols": [
            "http",
            "https"
        ],
        "methods": [
            "GET",
            "POST"
        ],
        "paths": [
            "/posts",
            "/users"
        ],
        "https_redirect_status_code": 426,
        "regex_priority": 0,
        "strip_path": false,
        "path_handling": "v0",
        "preserve_host": false,
        "request_buffering": true,
        "response_buffering": true,
        "tags": [
            "user-level"
        ]
    }
'
```

Remind

-   strip_path (boolean) - When matching a route via one of the paths, strip the matching prefix from the upstream request URL

[Reference](https://docs.konghq.com/gateway/api/admin-ee/latest/#/operations/create-route-with-service)

To List all routes

```bash
curl -i -s -X GET http://localhost:8001/routes
```

[Reference](https://docs.konghq.com/gateway/api/admin-ee/latest/#/operations/list-route)

To test proxy a request

```bash
# pokemon api via direct
curl -i -X GET https://pokeapi.co/api/v2/pokemon?limit=10&offset=0
# pokemon api via kong
curl -i -X GET http://localhost:8000/api/v2/pokemon?limit=10&offset=0
curl -i -X GET http://localhost:8000/api/v2/berry?limit=10&offset=0

# jsonplaceholder via direct
curl -i -X GET https://jsonplaceholder.typicode.com/posts
curl -i -X GET https://jsonplaceholder.typicode.com/users
# jsonplaceholder via kong
curl -i -X GET http://localhost:8000/posts
curl -i -X GET http://localhost:8000/users
```

[PokeAPI](https://pokeapi.co/docs/v2#resource-listspagination-section)
[JsonPlaceholder](https://jsonplaceholder.typicode.com/)

### 5. apply rate limiting

To list all plugins

```bash
curl -i -X GET http://localhost:8001/plugins?size=100
```

To apply rate limiting plugin with a route

```bash
curl -i -X POST http://localhost:8001/routes/my-pokemon-service-route/plugins \
--header 'Content-Type: application/json' \
--data '
    {
        "name": "rate-limiting",
        "instance_name": "rate-limiting-pokemon",
        "config": {
            "hour": 500,
            "minute": 5
        },
        "protocols": [
            "http"
        ],
        "enabled": true
    }
'
```

[Reference](https://docs.konghq.com/gateway/api/admin-ee/latest/#/operations/create-plugin-with-route)

### 6. set up consumers and keys

To list all consumer

```bash
curl -i -X GET http://localhost:8001/consumers?size=100
```

To create a new consumer

```bash
curl -i -X POST http://localhost:8001/consumers \
--header 'Content-Type: application/json' \
--data '
    {
        "username": "trust",
        "custom_id": "1"
    }
'
```

[Reference](https://docs.konghq.com/gateway/api/admin-ee/latest/#/operations/create-consumer)

To add key authentication, need to enable Key Auth plugin.

```bash
curl -i -X POST http://localhost:8001/consumers/trust/key-auth \
--header 'Content-Type: application/json' \
--data '
    {
        "key": "password"
    }
'
```

To list api key for all consumers

```bash
curl -i -X GET http://localhost:8001/key-auths
```

To apply key authentication plugin with a

```bash
curl -i -X POST http://localhost:8001/routes/my-pokemon-service-route/plugins \
--header 'Content-Type: application/json' \
--data '
    {
        "name": "key-auth",
        "instance_name": "key-auth-pokemon",
        "protocols": [
            "http"
        ],
        "enabled": true
    }
'
```

To request api with key-auth plugin

```bash
curl -i -X GET http://localhost:8000/api/v2/pokemon?limit=10&offset=0 \
--header 'Content-Type: application/json' \
--header 'apikey: password'
```

[Reference](https://docs.konghq.com/hub/kong-inc/key-auth/)

### 7. (optional) enable RBAC to secure admin api

To configure RBAC with basic authentication

```conf
database = postgres
enforce_rbac = on
admin_gui_auth = basic-auth
admin_gui_session_conf = {"secret":"secret","storage":"kong","cookie_secure":false}
admin_listen = 0.0.0.0:8001, 0.0.0.0:8444 ssl
```

To set super admin account, need to set password before kong migration (default username: `kong_admin`)

```yaml
KONG_PASSWORD: ${KONG_PASSWORD:-password}
```

To generate `Kong-Admin-Token` to request Admin API

```bash
# basic auth
curl -i -X GET http://localhost:8001/auth \
--header 'Content-Type: application/json' \
--header 'Kong-Admin-User: kong_admin' \
--user 'kong_admin:password'

# using session (Cookie) in response or kong admin token from registration
```

To test

```bash
curl --location 'http://localhost:8001/services' \
--header 'Content-Type: application/json' \
--header 'Kong-Admin-User: kong_admin' \
--header 'Cookie: session=${session}'

# or

curl -i -s -X POST http://localhost:8001/services \
--header 'Content-Type: application/json' \
--header 'Kong-Admin-Token: ${KONG_ADMIN_TOKEN}' \
--data '
    {
        "name": "my-user-service",
        "retries": 5,
        "protocol": "https",
        "host": "jsonplaceholder.typicode.com",
        "port": 443,
        "path": "/",
        "connect_timeout": 6000,
        "write_timeout": 6000,
        "read_timeout": 6000,
        "tags": [
            "user-level"
        ],
        "enabled": true
    }
'
```

[Reference](https://docs.konghq.com/gateway/3.10.x/production/access-control/start-securely/)

## Plugin

To setup

```bash
# create consumers
curl -i -X POST http://localhost:8001/consumers \
--header 'Content-Type: application/json' \
--header 'Kong-Admin-Token: ${KONG_ADMIN_TOKEN}' \
--data '
    {
        "username": "user 1",
        "custom_id": "1"
    }
'

curl -i -X GET http://localhost:8001/consumers \
--header 'Content-Type: application/json' \
--header 'Kong-Admin-Token: ${KONG_ADMIN_TOKEN}'

# create services and routes
curl -i -s -X POST http://localhost:8001/services \
--header 'Content-Type: application/json' \
--header 'Kong-Admin-Token: ${KONG_ADMIN_TOKEN}' \
--data '
    {
        "name": "my-pokemon-service",
        "retries": 5,
        "protocol": "https",
        "host": "pokeapi.co",
        "port": 443,
        "path": "/",
        "connect_timeout": 6000,
        "write_timeout": 6000,
        "read_timeout": 6000,
        "tags": [
            "user-level"
        ],
        "enabled": true
    }
'

curl -i -X POST http://localhost:8001/services/my-pokemon-service/routes \
--header 'Content-Type: application/json' \
--header 'Kong-Admin-Token: ${KONG_ADMIN_TOKEN}' \
--data '
    {
        "name": "my-pokemon-service-route",
        "protocols": [
            "http",
            "https"
        ],
        "methods": [
            "GET",
            "POST"
        ],
        "paths": [
            "/api/v2/pokemon",
            "/api/v2/berry"
        ],
        "https_redirect_status_code": 426,
        "regex_priority": 0,
        "strip_path": false,
        "path_handling": "v0",
        "preserve_host": false,
        "request_buffering": true,
        "response_buffering": true,
        "tags": [
            "user-level"
        ]
    }
'
```

### 1. Basic Authentication

To test [basic authentication](https://docs.konghq.com/hub/kong-inc/basic-auth/)

```bash
# apply plugin
curl -i -X POST http://localhost:8001/routes/my-pokemon-service-route/plugins \
--header 'Content-Type: application/json' \
--header 'Kong-Admin-Token: ${KONG_ADMIN_TOKEN}' \
--data '
    {
        "name": "basic-auth",
        "instance_name": "basic-auth-pokemon",
        "config": {
            "hide_credentials": false
        },
        "enabled": true
    }
'

# create basic auth credential
curl -i -X POST http://localhost:8001/consumers/trust/basic-auth \
--header 'Content-Type: application/json' \
--header 'Kong-Admin-Token: ${KONG_ADMIN_TOKEN}' \
--data '
    {
        "username": "basic-auth-user",
        "password": "password"
    }
'

# base64
echo -n ${PLAIN_TEXT} | base64 # encode
echo ${ENCODED_TEXT} | base64 -D # decode

curl -i -X GET http://localhost:8000/api/v2/pokemon?limit=10&offset=0 \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic ${ENCODED_TEXT}'
```

### 2. JWT

To test [jwt](https://docs.konghq.com/hub/kong-inc/jwt/)

```bash
# apply plugin
curl -i -X POST http://localhost:8001/routes/my-pokemon-service-route/plugins \
--header 'Content-Type: application/json' \
--header 'Kong-Admin-Token: ${KONG_ADMIN_TOKEN}' \
--data '
    {
        "name": "jwt",
        "instance_name": "jwt-pokemon",
        "config": {
            "key_claim_name": "iss",
            "secret_is_base64": false,
            "claims_to_verify": ["exp","nbf"],
            "header_names": ["authorization"]
        },
        "enabled": true
    }
'

# create jwt credential
curl -i -X POST http://localhost:8001/consumers/trust/jwt \
--header 'Content-Type: application/json' \
--header 'Kong-Admin-Token: ${KONG_ADMIN_TOKEN}' \
--data '
    {
        "algorithm": "HS256",
        "secret": "this_is_a_super_secret_value"
    }
'

# jwt
# Using JWT debugger at https://jwt.io
# iss is the key in GET consumers/${user}/jwt

curl -i -X GET http://localhost:8000/api/v2/pokemon?limit=10&offset=0 \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer ${JWT}'
```

### 3. OAuth 2.0 Authentication

To test [OAuth2](https://docs.konghq.com/hub/kong-inc/oauth2/)

```bash
# apply plugin
curl -i -X POST http://localhost:8001/routes/my-pokemon-service-route/plugins \
--header 'Content-Type: application/json' \
--header 'Kong-Admin-Token: 8FdCSAevQFSaXdrUnFRGUG8KEZBf7N7t' \
--data '
    {
        "name": "oauth2",
        "instance_name": "oauth2-pokemon",
        "config": {
            "scopes": [
                "email",
                "phone",
                "address"
            ],
            "mandatory_scope": true,
            "provision_key": "<autogenerated>",
            "enable_authorization_code": true
        }
    }
'

# pending
```
