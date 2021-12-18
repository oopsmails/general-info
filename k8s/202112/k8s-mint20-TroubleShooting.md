
#  Trouble Shootings

## Error: kubectl on localhost:8080 was refused

- Ref:

https://discuss.kubernetes.io/t/the-connection-to-the-server-localhost-8080-was-refused-did-you-specify-the-right-host-or-port/1464/5

### Check if there is no contexts are configured.


```
kubectl config view


albert@albert-mint20:~$ kubectl config view
apiVersion: v1
clusters: null
contexts: null
current-context: ""
kind: Config
preferences: {}
users: null

```

- You missed initialising

sudo kubeadm init --pod-network-cidr=10.244.0.0/16

sudo kubeadm init



### further, not try because need to configure contexts 

- Run these commands to fix it.

sudo cp /etc/kubernetes/admin.conf HOME/ 
sudo chown (id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf

- Below commands solved the problem for me.
mkdir ~/.kube
vim ~/.kube/config
and copy the config file from mster node to nodes config file

- Run
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf HOME/.kube/config sudo chown (id -u):$(id -g) $HOME/.kube/config

- All I have to do is use the same user (non-root) used to issue the command: 

minikube start --vm-driver="docker"


## Error: Deploy image cannot see the image build with local Docker

Failed to pull image "oopsmails/mockbackend:v1": rpc error: code = Unknown desc = Error response from daemon: pull access denied for oopsmails/mockbackend, repository does not exist or may require 'docker login': denied: requested access to the resource is denied

- Ref:

https://stackoverflow.com/questions/42564058/how-to-use-local-docker-images-with-minikube

- There is one essay and effective way to push your local Docker image directly to minikube, which will save time from building the images in minikube again.

```
minikube image load <image name>


(minikube cache add <image name> - old deprecated way, for reference)

```

More details here

All possible method to push images to minikube are mention here: https://minikube.sigs.k8s.io/docs/handbook/pushing/

- Pushing images
comparing 8 ways to push your image into a minikube cluster.
Glossary:

Pull means downloading a container image directly from a remote registry.

Push means uploading a container image directly to a remote registry.

Load takes an image that is available as an archive, and makes it available in the cluster.

Save saves an image into an archive.

Build takes a “build context” (directory) and creates a new image in the cluster from it.

Tag means assigning a name and tag.

## kubernetes external ip pending

- Note: After *kubectl apply -f nodejs-simple-rest-service-loadbalancer.yaml*, the service will be in "pending ..." in dashboard

```
kubectl get svc nodejs-simple-rest-service

kubectl describe svc nodejs-simple-rest-service
```

EXTERNAL-IP will be showing as "pending"

### Solution 1: Also working but need to run it every time.

Ref: https://stackoverflow.com/questions/44110876/kubernetes-service-external-ip-pending  

Using a custom Kubernetes Cluster (using minikube, kubeadm or the like). In this case, there is no LoadBalancer integrated (unlike AWS or Google Cloud). With this default setup, you can only use NodePort or an Ingress Controller.

If you are using minikube the run "minikube tunnel". Now check your services you will get the public ip. Here is the doc for more information [minikube.sigs.k8s.io/docs/tasks/loadbalancer](https://minikube.sigs.k8s.io/docs/handbook/accessing/)

So, open another terminal, run *minikube tunnel*  

Then, all OK!

```
albert@albert-mint20:~/Documents/sharing/github/nodejs-simple-rest$ kubectl get svc nodejs-simple-rest-service
NAME                         TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)          AGE
nodejs-simple-rest-service   LoadBalancer   10.107.156.231   10.107.156.231   3000:31328/TCP   15m
```

- Side notes: 

https://minikube.sigs.k8s.io/docs/handbook/accessing/  

Cleaning up orphaned routes 

If the minikube tunnel shuts down in an abrupt manner, it may leave orphaned network routes on your system. If this happens, the ~/.minikube/tunnels.json file will contain an entry for that tunnel. To remove orphaned routes, run:

```
minikube tunnel --cleanup
```

### Solution 2: To use NodePort or an Ingress

It looks like you are using a custom Kubernetes Cluster (using minikube, kubeadm or the like). In this case, there is no LoadBalancer integrated (unlike AWS or Google Cloud). With this default setup, you can only use NodePort or an Ingress Controller. With the Ingress Controller you can setup a domain name which maps to your pod.

More, need to enable ingress on minikube!

```
kubectl apply -f nodejs-simple-rest-ingress.yaml

minikube addons enable ingress <---------------------------- used for minikube, 20211216

kubectl get po -n ingress-nginx -o wide <----------------------------- verify
```

## Error: Kubernetes: kubectl run: command not found

- This was actually not encountered when using *minikube kubectl*, but nice to know.

I had a similar error when I was setting up Kubernetes on Linux for the first time:

When I try to run the commands:

kubectl cluster-info
kubectl version
I get the error:

-bash: kubectl: command not found
Here's how I fixed it:

Download the latest Kubernetes release with the command:

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
Make the kubectl binary executable:

chmod +x ./kubectl
Move the binary in to your PATH:

sudo mv ./kubectl /usr/local/bin/kubectl
Test to ensure the version you installed is up-to-date:

kubectl cluster-info
kubectl version
You can read up more about it in the Kubernetes Official Docs: Install and Set Up kubectl


## Error: Cannot connect to container bash

- minikube kubectl exec no such file or directory: unknown command terminated with exit code 126
- **See k8s-mint20-docker-run.md** for more tested information on creating image, Dockerfile

### Solution 1: preferred

- if you do not want to add extra size to your image, you can use ash or sh that ships with alpine.

```
kubectl exec -it nodejs-simple-rest-deployment-544cd7c5d6-929jm -- /bin/bash // not working

kubectl exec -it nodejs-simple-rest-deployment-544cd7c5d6-929jm -- /bin/sh
kubectl exec -it nodejs-simple-rest-deployment-544cd7c5d6-929jm -- /bin/ash
```

### Solution 2: Adding bash in alpine base image, ok but still increase image size

Alpine docker image doesn't have bash installed by default. You will need to add following commands to get bash:

```
RUN apk update && apk add bash

```

If youre using Alpine 3.3+ then you can just do

```
RUN apk add --no-cache bash

```

to keep docker image size small.


### Solution 3: Not Preferred, or using *From node* but this will increase image size a lot

You can't shell in because neither sh nor bash are available in the container. A lot of times these are removed for the sake of efficiency and having a minimal container image.

If you'd like to shell into the container I recommend you build your own image in include bash or sh in it.

You can see here that the Dockerfile builds an image that has nothing but the static binary. For that, you want to change the base image. For example:

*FROM alpine*

instead of:

*FROM scratch*


## Error: unknown field "name" in io.k8s.api.core.v1.EnvFromSource;

name should be indented under *envFrom* 



