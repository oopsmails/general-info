
# How to Install Minikube on Linux Mint 20

LOG:

- 20211215: tried

- Ref:

https://minikube.sigs.k8s.io/docs/start/

## Installation 

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube


## Start your cluster

From a terminal with administrator access (but not logged in as root), run:

minikube start

```
albert@albert-mint20:~$ minikube start
😄  minikube v1.24.0 on Linuxmint 20.1 (vbox/amd64)
✨  Automatically selected the docker driver. Other choices: none, ssh
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
💾  Downloading Kubernetes v1.22.3 preload ...
    > preloaded-images-k8s-v13-v1...: 501.73 MiB / 501.73 MiB  100.00% 17.02 Mi
    > gcr.io/k8s-minikube/kicbase: 355.77 MiB / 355.78 MiB  100.00% 6.98 MiB p/
🔥  Creating docker container (CPUs=2, Memory=2200MB) ...
🐳  Preparing Kubernetes v1.22.3 on Docker 20.10.8 ...
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default

```


## Interact with your cluster

### If you already have kubectl installed, you can now use it to access your shiny new cluster:

kubectl get po -A

### Alternatively, minikube can download the appropriate version of kubectl and you should be able to use it like this:

minikube kubectl -- get po -A

### You can also make your life easier by adding the following to your shell config:

alias kubectl="minikube kubectl --"

Initially, some services such as the storage-provisioner, may not yet be in a Running state. This is a normal condition during cluster bring-up, and will resolve itself momentarily. 

### For additional insight into your cluster state, minikube bundles the Kubernetes Dashboard, allowing you to get easily acclimated to your new environment:

```
minikube dashboard


albert@albert-mint20:~$ minikube dashboard
🔌  Enabling dashboard ...
    ▪ Using image kubernetesui/dashboard:v2.3.1
    ▪ Using image kubernetesui/metrics-scraper:v1.0.7
🤔  Verifying dashboard health ...
🚀  Launching proxy ...
🤔  Verifying proxy health ...
🎉  Opening http://127.0.0.1:43145/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/ in your default browser...
Opening in existing browser session

```

## Deploy applications

### Create a sample deployment and expose it on port 8080:

```
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4
kubectl expose deployment hello-minikube --type=NodePort --port=8080
```

### It may take a moment, but your deployment will soon show up when you run:

```
kubectl get services hello-minikube
```

### The easiest way to access this service is to let minikube launch a web browser for you:

minikube service hello-minikube


### Alternatively, use kubectl to forward the port:

```
kubectl port-forward service/hello-minikube 7080:8080
```

Tada! Your application is now available at http://localhost:7080/.

You should be able to see the request metadata from nginx such as the CLIENT VALUES, SERVER VALUES, HEADERS RECEIVED and the BODY in the application output. Try changing the path of the request and observe the changes in the CLIENT VALUES. Similarly, you can do a POST request to the same and observe the body show up in BODY section of the output.


### LoadBalancer deployments

- To access a LoadBalancer deployment, use the “minikube tunnel” command. Here is an example deployment:

```
kubectl create deployment balanced --image=k8s.gcr.io/echoserver:1.4  
kubectl expose deployment balanced --type=LoadBalancer --port=8080
```

- In another window, start the tunnel to create a routable IP for the ‘balanced’ deployment:

minikube tunnel

- To find the routable IP, run this command and examine the EXTERNAL-IP column:

```
kubectl get services balanced
```

Your deployment is now available at *<EXTERNAL-IP>:8080*


## Manage your cluster

- Pause Kubernetes without impacting deployed applications:

minikube pause

- Unpause a paused instance:

minikube unpause

- Halt the cluster:

minikube stop

- Increase the default memory limit (requires a restart):

minikube config set memory 16384

- Browse the catalog of easily installed Kubernetes services:

minikube addons list

- Create a second cluster running an older Kubernetes release:

minikube start -p aged --kubernetes-version=v1.16.1

- Delete all of the minikube clusters:

minikube delete --all



##



