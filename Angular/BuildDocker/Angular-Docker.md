
- https://www.youtube.com/watch?v=etA5xiX5TCA

# Create Angular App and Deploy it to Docker Hub

- vs code docker plugin: can generate docker commands

- https://github.com/HoussemDellai/angular-app-kubernetes
- https://github.com/HoussemDellai/demo-angular-app

## Docker

### Dockerfile

```
# stage 1
FROM node:latest as node
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod

# stage 2
FROM nginx:alpine
COPY --from=node /app/dist/angular-app /usr/share/nginx/html
```

### docker build

#### general build and test

`docker build --rm -f angular-app/Dockerfile -t angular-app:v1 angular-app`

`docker run --rm -d -p 80:80 angular-app:v1`

#### tag image: can have multiple tags when building the image

`docker build -t oopsmails/angular-app:latest -t oopsmails/angular-app:v0.1 .`

### docker push

```
docker login
docker push oopsmails/angular-app:v0.1
```


