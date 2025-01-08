# dockerized-golang
Dockerized Golang Application



#### Dockerize for scratch:
```bash
docker build -t dockerized-golang-scratch -f Dockerfile .

docker run -p 3000:3000 dockerized-golang-scratch:latest
```


#### Dockerize for distroless:
```bash
docker build -t dockerized-golang-distroless -f Dockerfile .

docker run -p 3001:3000 dockerized-golang-distroless:latest
```

## Docker Images

![Docker Images](https://github.com/nurettintopal/dockerized-golang/blob/main/image.png?raw=true)


## license
dockerized-golang is open-sourced software licensed under the [MIT license](LICENSE).