
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

docker build --rm -f $SRC_FOLDER/Dockerfile -t oopsmails/nodejs-simple-rest:v1 $SRC_FOLDER
```

### Run the v1 image locally to test.

```
docker run --rm --name nodejs-simple-rest -d -p 3000:3000 oopsmails/nodejs-simple-rest:v1

```

- run *ip addr*, get ip address

```
4: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:37:16:a2:a7 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:37ff:fe16:a2a7/64 scope link 
       valid_lft forever preferred_lft forever
5: br-2bdd24f433c3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:73:fc:5a:5f brd ff:ff:ff:ff:ff:ff
    inet 192.168.49.1/24 brd 192.168.49.255 scope global br-2bdd24f433c3
       valid_lft forever preferred_lft forever
    inet6 fe80::42:73ff:fefc:5a5f/64 scope link 
       valid_lft forever preferred_lft forever
```

- Verify: OK, seeing "v1" on the page.

http://localhost:3000/api

http://192.168.49.1:3000/api

http://172.17.0.1:3000/api

- Not OK

http://192.168.49.255:3000/api

- Stop docker run and make sure above NOT working anymore

```
docker stop nodejs-simple-rest
```

### Tag the image before uploading, here to DockerHub

```
docker tag oopsmails/nodejs-simple-rest:v1 oopsmails/nodejs-simple-rest:v1
```

### Upload to DockerHub
```
docker login 

docker push oopsmails/nodejs-simple-rest:v1

```
Verify at dockerhub ...

### Kubernetes: Create deployment.yaml

```
kubectl apply -f nodejs-simple-rest-deployment.yaml
```

- Verify at minikube dashboard

  - Deployment: nodejs-simple-rest-deployment
  - Pod: 2/2, nodejs-simple-rest-deployment-544cd7c5d6-bz5j7 ...

### Kubernetes: Create service.yaml
```
kubectl apply -f nodejs-simple-rest-service-nodeport.yaml <---- this is using nodeport, use this for simplicity.

kubectl apply -f nodejs-simple-rest-service-loadbalancer.yaml <------------- this is using loadbalancer, can be used with *minikube tunnel* only

kubectl apply -f nodejs-simple-rest-ingress.yaml <------------ need further test
```

- When using NodePort, use following to find out url

```
minikube service nodejs-simple-rest-service --url
```

http://192.168.49.2:30132/api <--------------------------- OK, seeing seeing "v1" on the page.


- When using loadbalancer, service will be "pending", with *EXTERNAL-IP* "pending", see k8s-mint20-TroubleShooting.md

http://10.107.156.231:3000/api ---> OK, seeing "v1" on the page.

http://localhost:3000/api ---> Not ok anymore.



kubectl get pods | grep nodejs-simple-rest

kubectl logs nodejs-simple-rest-deployment-544cd7c5d6-929jm

kubectl exec -it nodejs-simple-rest-deployment-544cd7c5d6-929jm -- /bin/bash ???

nodejs-simple-rest-deployment-544cd7c5d6-929jm

20211216: Here!

kubectl delete deployment nodejs-simple-rest-deployment

kubectl delete services nodejs-simple-rest-service


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







