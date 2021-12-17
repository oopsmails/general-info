
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

docker inspect oopsmails/nodejs-simple-rest:v1
```

### Run the v1 image locally to test.

**See k8s-mint20-docker-run.md** for more tested information.

```
docker run --rm --name nodejs-simple-rest -d -p 2000:3000 oopsmails/nodejs-simple-rest:v1

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

http://localhost:2000/api

http://192.168.49.1:2000/api

http://172.17.0.1:2000/api

- Not OK

http://192.168.49.255:2000/api

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

- **NOTE: instead of use command line kubectl, we can use minikube dashboard to complete operations, i.e, create and rolling up ...**

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

- Not going to delete deployment, but using dashboard to update Deployment by updating yaml file!!!!!

kubectl delete deployment nodejs-simple-rest-deployment

kubectl delete services nodejs-simple-rest-service


## Build image v2 and deploy to Kubernetes by using rolling technique:

### make change to application and then build image v2.0

Simply, change app.js, from *ChangingVersion-v1* to *ChangingVersion-v2*

```
app.get("/api", (req, res, next) => {
    res.json(["Apple", "Banana", "Cherry", "Dewberry", "Grape", "ChangingVersion-v2"]);  <----------- change version here.
});

```
### build image v2
```
SRC_FOLDER=/home/albert/Documents/sharing/github/nodejs-simple-rest

docker build --rm -f $SRC_FOLDER/Dockerfile -t oopsmails/nodejs-simple-rest:v2 $SRC_FOLDER

```

### Run the v2 image locally to test.

```
- remove running v1 if existing
docker rm -f nodejs-simple-rest

docker run --rm --name nodejs-simple-rest -d -p 2000:3000 oopsmails/nodejs-simple-rest:v2

- Verify: OK, seeing "v1" on the page.

http://localhost:2000/api

```

### rolling up to v2 in kubernetes:

- Failed to pull image from local

Failed to pull image "oopsmails/nodejs-simple-rest:v2": rpc error: code = Unknown desc = Error response from daemon: manifest for oopsmails/nodejs-simple-rest:v2 not found: manifest unknown: manifest unknown


- Using *minikube image load* to load images from local

**Note: This will work ONLY if using *imagePullPolicy: Never* in *nodejs-simple-rest-deployment-rolling.yaml*, if using *Always*, then will NOT work**

```
docker tag oopsmails/nodejs-simple-rest:v2 oopsmails/nodejs-simple-rest:v2

minikube image load <image name>
minikube image load oopsmails/nodejs-simple-rest:v2

minikube cache add oopsmails/nodejs-simple-rest:v2


kubectl apply -f $SRC_FOLDER/nodejs-simple-rest-deployment-rolling.yaml

```

- Verify

http://192.168.49.2:30132/api <---------------------- internal

```
["Apple","Banana","Cherry","Dewberry","Grape","ChangingVersion-v2"] <------------------ seeing v2 here!
```


- Test around:

Modify yaml file to play around ...

```

spec:
  replicas: 6
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 25%



minikube tunnel

change around service, to see external IP: http://10.103.204.114:3000/api <---------------------- external

kubectl get svc

NodePort
LoadBalancer

kubectl get pods | grep nodejs-simple-rest

kubectl exec -it nodejs-simple-rest-deployment-68868b8469-977tb -- /bin/bash


kubectl port-forward service/nodejs-simple-rest-service 5000:3000

http://localhost:5000/api <---------------------- after port-forward, in virtualbox


on host machine (windows 11), all not working!!!!

http://192.168.49.1:5000/api
http://127.0.0.1:5000/api
http://10.0.2.15:5000/api
http://192.168.56.1:5000/api


even using NAT port forwarding, not working!!!!

http://localhost:5000/api

```







