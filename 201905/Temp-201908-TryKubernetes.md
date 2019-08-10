
# Run simple nodejs restful api application using Kubernetes, local dev machine

## Build sample nodejs app to be used

Using C:\GithubStaging\nodejs-simple-rest, which already can be run sucessfully locally

## Test sample app:

http://localhost:3000/api

## Build image

C:\GithubStaging> docker build --rm -f nodejs-simple-rest/Dockerfile -t nodejs-simple-rest:v1 nodejs-simple-rest

## Run the image locally to test.

docker run --rm --name nodejs-simple-rest -d -p 3000:3000 nodejs-simple-rest:v1

This is running on local "default" VM, not "minikube", so it is "192.168.99.100", not "192.168.99.101" yet.

http://192.168.99.100:3000/api


## Tag the image before uploading, here to DockerHub

docker tag nodejs-simple-rest:v1 oopsmails/nodejs-simple-rest:v1

## Upload to DockerHub

docker login 

docker push oopsmails/nodejs-simple-rest:v1

## Start "minikube"

** Don't start through VM, instead need to run following by command line.

minikube start
minikube ip
kubectl version
minikube dashboard 
Can run dashboard in background like other apps, minikube dashboard &

Note:

$ minikube start
* minikube v1.1.1 on windows (amd64)
* Tip: Use 'minikube start -p <name>' to create a new cluster, or 'minikube delete' to delete this one.
* Restarting existing virtualbox VM for "minikube" ...
* Waiting for SSH access ...
* Found network options:
  - NO_PROXY=192.168.99.100
* Configuring environment for Kubernetes v1.14.3 on Docker 18.09.6
  - env NO_PROXY=192.168.99.100
* Relaunching Kubernetes v1.14.3 using kubeadm ...
* Verifying: apiserver proxy etcd scheduler controller dns
* Done! kubectl is now configured to use "minikube"

$ minikube ip
192.168.99.101

$ kubectl version
Client Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.0", GitCommit:"641856db18352033a0d96dbc99153fa3b27298e5", GitTreeState:"clean", BuildDate:"2019-03-25T15:53:57Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"windows/amd64"}
Server Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.3", GitCommit:"5e53fd6bc17c0dec8434817e69b04a25d8ae0ff0", GitTreeState:"clean", BuildDate:"2019-06-06T01:36:19Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}

** minikube dashboard &: need to be run with Docer Terminal (or Git Bash?) to make & working at background, ie., & will not work with windows command line.

$ minikube dashboard &
[1] 32608

$ * Enabling dashboard ...
* Verifying dashboard health ...
* Launching proxy ...
* Verifying proxy health ...
* Opening http://127.0.0.1:56729/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/ in your default browser...

## Create deployment.yaml

kubectl apply -f nodejs-simple-rest-deployment.yaml

## Create service.yaml

kubectl apply -f nodejs-simple-rest-service.yaml


## Testing:

$ minikube service nodejs-simple-rest-service --url
http://192.168.99.101:30100

http://192.168.99.101:30100/api -> working!

- Also, can use Virtual Box Manager, preview, command line, Curl, to debug if image is updated.
the "Cluster IP" can be found by `kubectl get svc`

curl get http://10.103.84.70:3000/api 

see Temp-201908-TryKubernetes-CurlViaKernal.png


## Build image v2.0, make changes

docker build --rm -f nodejs-simple-rest/Dockerfile -t nodejs-simple-rest:v2 nodejs-simple-rest

docker run --rm --name nodejs-simple-rest -d -p 3000:3000 nodejs-simple-rest:v2

docker run --rm --name nodejs-simple-rest -d -p 3000:3000 oopsmails/nodejs-simple-rest:v2

docker tag nodejs-simple-rest:v2 oopsmails/nodejs-simple-rest:v2

docker push oopsmails/nodejs-simple-rest:v2

- Option 1: Command line edit deployment

kubectl edit deployment nodejs-simple-rest-deployment

$ kubectl edit deployment nodejs-simple-rest-deployment
deployment.extensions/nodejs-simple-rest-deployment edited

- Option 2: Using yaml to edit deployment

kubectl apply -f nodejs-simple-rest-deployment-rolling.yaml

- Option 3: set image?

kubectl set image deployment nodejs-simple-rest nginx=nginx:1.9.1

- Rollout deployment change

$ kubectl rollout status deployment.extensions/nodejs-simple-rest-deployment
deployment "nodejs-simple-rest-deployment" successfully rolled out


## Kubernetes using local docker images

https://stackoverflow.com/questions/42564058/how-to-use-local-docker-images-with-minikube


### Option 1:
As the README describes, you can reuse the Docker daemon from Minikube with eval $(minikube docker-env).

So to use an image without uploading it, you can follow these steps:

- Set the environment variables with eval $(minikube docker-env)
- Build the image with the Docker daemon of Minikube (eg docker build -t my-image .)
- Set the image in the pod spec like the build tag (eg my-image)
- Set the imagePullPolicy to Never, otherwise Kubernetes will try to download the image.

Important note: You have to run eval $(minikube docker-env) on each terminal you want to use, since it only sets the environment variables for the current shell session.

### Option 2:

```
# Start minikube
minikube start

# Set docker env
eval $(minikube docker-env)

# Build image
docker build -t foo:0.0.1 .

# Run in minikube
kubectl run hello-foo --image=foo:0.0.1 --image-pull-policy=Never

# Check that it's running
kubectl get pods
```

## Problems:
- kubernetes external ip pending

It looks like you are using a custom Kubernetes Cluster (using minikube, kubeadm or the like). In this case, there is no LoadBalancer integrated (unlike AWS or Google Cloud). With this default setup, you can only use NodePort or an Ingress Controller. With the Ingress Controller you can setup a domain name which maps to your pod.

More, need to enable ingress on minikube!

```
kubectl apply -f nodejs-simple-rest-ingress.yaml

minikube addons enable ingress
```

- image is NOT updated

https://stackoverflow.com/questions/33112789/how-do-i-force-kubernetes-to-re-pull-an-image

Old image of v2 existing, then need to set following in nodejs-simple-rest-deployment-rolling.yaml, in order to always pull image

`imagePullPolicy: Always`



## View the Logs:

https://medium.com/@awkwardferny/getting-started-with-kubernetes-ingress-nginx-on-minikube-d75e58f52b6c

https://medium.com/@Oskarr3/setting-up-ingress-on-minikube-6ae825e98f82



Prints the logs for the nginx-ingress-controller.
$ kubectl get pods -n kube-system | grep nginx-ingress-controller
nginx-ingress-controller-5984b97644-qbwtv   1/1       Running
$ kubectl logs -n kube-system nginx-ingress-controller-5984b97644-qbwtv
....
I0831 21:45:34.090212       5 nginx.go:271] Starting NGINX process
....



================================================

## Cheat sheet to debug:

https://kubernetes.io/docs/reference/kubectl/cheatsheet/

kubectl logs my-pod
kubectl logs nodejs-simple-rest-deployment-77678bf459-6c2mr


===================================

gcloud container clusters create cluster1 --zone=us-central1-f



==================================================


- Thanks to:

https://www.youtube.com/watch?v=DwlIn9zOcfc

https://www.youtube.com/watch?v=CsWoMpK3EtE&pbjreload=10 : make local docker run reloadabe, nodemon



