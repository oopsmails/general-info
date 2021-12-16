
# Try Kubernetes on Mint20:

- Linux Mint 20.2:

## Setting up Kubernetes Dashboard

minikube status

minikube start

minikube dashboard

alias kubectl="minikube kubectl --"

kubectl version -o json


## Build image v1 and deploy to Kubernetes:


### build image
```
SRC_FOLDER=/home/albert/Documents/sharing/github/nodejs-simple-rest

docker build --rm -f $SRC_FOLDER/Dockerfile -t oopsmails/nodejs-simple:v1 $SRC_FOLDER
```

### Run the v1 image locally to test.

```
docker run --rm --name nodejs-simple -d -p 3000:3000 oopsmails/nodejs-simple:v1

```

http://192.168.232.128:3000/api

### Tag the image before uploading, here to DockerHub

```
docker tag oopsmails/nodejs-simple:v1 oopsmails/nodejs-simple:v1
```

### Upload to DockerHub
```
docker login 

docker push oopsmails/nodejs-simple:v1

```

### Kubernetes: Create deployment.yaml

`kubectl apply -f nodejs-simple-rest-deployment.yaml`

### Kubernetes: Create service.yaml
```
kubectl apply -f nodejs-simple-rest-service.yaml <---- not using nodeport
kubectl apply -f nodejs-simple-rest-service-loadbalancer.yaml
```

http://localhost:3000/api


## Build image v2 and deploy to Kubernetes by using rolling technique:

### make change to application and then build image v2.0
```
docker build --rm -f nodejs-simple-rest/Dockerfile -t nodejs-simple-rest:v2 nodejs-simple-rest
docker build --rm -f /Users/albert/Documents/github/nodejs-simple-rest/Dockerfile -t nodejs-simple-rest:v2 /Users/albert/Documents/github/nodejs-simple-rest
```

### run locally for testing
`docker run --rm --name nodejs-simple-rest -d -p 3000:3000 nodejs-simple-rest:v2`

-> error: docker: Error response from daemon: driver failed programming external connectivity on endpoint nodejs-simple-rest (c39d6bbed984a362d7c86dacfc3731881b043ce5c107fee10cb15a125bb4fac2): Error starting userland proxy: listen tcp 0.0.0.0:3000: bind: address already in use.

because kubernetes "nodejs-simple-rest-service" service is using port 3000, delete the service to test v2, before doing that, may need to set "nodejs-simple-rest-deployment" scale as 0, otherwise, need to change port back and forth.
Then run again.

### tag as v2
`docker tag nodejs-simple-rest:v2 oopsmails/nodejs-simple-rest:v2`

### push to docker hub
`docker push oopsmails/nodejs-simple-rest:v2`

### run locally (not on Kubernetes for testing purpose)
`docker run --rm --name nodejs-simple-rest -d -p 3000:3000 oopsmails/nodejs-simple-rest:v2`

### rolling up to v2 in kubernetes:

- set "nodejs-simple-rest-deployment" scale as 2, 

`kubectl apply -f nodejs-simple-rest-service-loadbalancer.yaml`

try: http://192.168.232.128:3000/api, still showing "v1", because still using image v1

- rolling up:

revise version and replicas in "nodejs-simple-rest-deployment-rolling.yaml" as necessary

`kubectl apply -f nodejs-simple-rest-deployment-rolling.yaml`

wait for a while, refresh dashboard to see the rolling process ....

http://192.168.232.128:3000/api

will see "v2"







