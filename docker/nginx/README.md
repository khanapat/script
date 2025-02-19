## default

```sh
# default path /usr/share/nginx/html
docker run -it --rm -d -p 8080:80 --name web nginx

# mount content
docker run -it --rm -d -p 8080:80 --name web -v ./content:/usr/share/nginx/html nginx
```

## customize configuration

```sh
# get default configuration
docker run --rm --entrypoint=cat nginx /etc/nginx/nginx.conf > ./nginx.conf

# mount configuration
docker run -it --rm -d -p 8080:80 --name web -v ./nginx.conf:/etc/nginx/nginx.conf:ro nginx
```

```txt
server {
    listen 80;

    location / {
        proxy_pass http://127.0.0.1:8080;
    }
}
```
