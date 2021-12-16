
# How to Install Minikube on Linux Mint 20

LOG:

- 20211215: tried

- Ref:

https://webme.ie/how-to-run-minikube-on-a-virtualbox-vm/

## Installation 

### First you will need to download and install minikube. Run the following command.
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_1.7.2-0_amd64.deb \
&& sudo dpkg -i minikube_1.7.2-0_amd64.deb

### Once minikube is installed we will need to do some configuration. 

In this scenario we are going to run minikube within a VM so we will need to use the None (bare-metal) driver. The none driver requires minikube to be run as root, until #3760 can be addressed. To make none the default driver run the following command


sudo minikube config set vm-driver none


### Now we should be able to start mimikube by running the following command

Minikube should now be running in your vm.  

sudo minikube start

### Next you will need to install kubectl the Kubernetes command-line tool, kubectl, allows you to run commands against Kubernetes clusters. 

To install kubectl run the following commands  

sudo apt-get update && sudo apt-get install -y apt-transport-https

### 

```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubectl

```


### We can test our minikube install by creating a Kubernetes Deployment using an existing image named echoserver, which is a simple HTTP server and expose it on port 8080 using --port.

To do this run the following command

kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10

```
albert@albert-mint20:~$ kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10
error: failed to create deployment: Post "http://localhost:8080/apis/apps/v1/namespaces/default/deployments?fieldManager=kubectl-create": dial tcp 127.0.0.1:8080: connect: connection refused

```
- Use sudo

sudo kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10


### To access the hello-minikube Deployment, expose it as a Service

kubectl expose deployment hello-minikube --type=NodePort --port=8080

sudo kubectl expose deployment hello-minikube --type=NodePort --port=8080

### The hello-minikube Pod is now launched but you have to wait until the Pod is up before accessing it via the exposed Service. 

Check if the Pod is up and running

minikube kubectl -- get pods --namespace kube-system

### Get the URL of the exposed Service to view the Service details:

sudo minikube service hello-minikube --url

albert@albert-mint20:/usr/bin$ sudo minikube service hello-minikube --url
http://10.0.2.15:31693


The option --type=NodePort specifies the type of the Service.

### If you no longer want the Service and cluster to run, you can delete them. Delete the hello-minikube Service:

kubectl delete services hello-minikube

sudo kubectl delete services hello-minikube

### Delete deployment

kubectl delete deployment hello-minikube

sudo kubectl delete deployment hello-minikube

### Add local image repo

minikube cache add oopsmails/mockbackend:v1

### Create and expose my mockbackend

```
sudo kubectl create deployment mockbackend-minikube --image=oopsmails/mockbackend:v1
sudo kubectl expose deployment mockbackend-minikube --type=NodePort --port=8888
sudo minikube service mockbackend-minikube --url

```

- test using postman

http://10.0.2.15:30006/backendmock/employee-api ------------> should be ok


### delete service

sudo kubectl delete services mockbackend-minikube

### minikube stop and delete

minikube stop
minikube delete

minikube start

## Others


/bin/linux

chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo cp ./kubectl /usr/local/bin/kubectl


## Running console log


```

albert@albert-mint20:~$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_1.7.2-0_amd64.deb \
> && sudo dpkg -i minikube_1.7.2-0_amd64.deb
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 15.4M  100 15.4M    0     0  11.7M      0  0:00:01  0:00:01 --:--:-- 11.7M
[sudo] password for albert:       
Selecting previously unselected package minikube.
(Reading database ... 281670 files and directories currently installed.)
Preparing to unpack minikube_1.7.2-0_amd64.deb ...
Unpacking minikube (1.7.2) ...
Setting up minikube (1.7.2) ...


albert@albert-mint20:~$ sudo minikube config set vm-driver none
⚠️  These changes will take effect upon a minikube delete and then a minikube start
albert@albert-mint20:~$ 
albert@albert-mint20:~$ 


albert@albert-mint20:~$ sudo minikube start
🎉  minikube 1.24.0 is available! Download it: https://github.com/kubernetes/minikube/releases/tag/v1.24.0
💡  To disable this notice, run: 'minikube config set WantUpdateNotification false'

🙄  minikube v1.7.2 on Linuxmint 20.1
✨  Using the none driver based on user configuration
🤹  Running on localhost (CPUs=4, Memory=7961MB, Disk=119932MB) ...
ℹ️   OS release is Linux Mint 20.1
🐳  Preparing Kubernetes v1.17.2 on Docker 20.10.7 ...
    ▪ kubelet.resolv-conf=/run/systemd/resolve/resolv.conf
💾  Downloading kubeadm v1.17.2
💾  Downloading kubelet v1.17.2
💾  Downloading kubectl v1.17.2
🚀  Launching Kubernetes ... 
🌟  Enabling addons: default-storageclass, storage-provisioner
🤹  Configuring local host environment ...

⚠️  The 'none' driver provides limited isolation and may reduce system security and reliability.
⚠️  For more information, see:
👉  https://minikube.sigs.k8s.io/docs/reference/drivers/none/

⚠️  kubectl and minikube configuration will be stored in /root
⚠️  To use kubectl or minikube commands as your own user, you may need to relocate them. For example, to overwrite your own settings, run:

    ▪ sudo mv /root/.kube /root/.minikube $HOME
    ▪ sudo chown -R $USER $HOME/.kube $HOME/.minikube

💡  This can also be done automatically by setting the env var CHANGE_MINIKUBE_NONE_USER=true
⌛  Waiting for cluster to come online ...
🏄  Done! kubectl is now configured to use "minikube"
💡  For best results, install kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/


albert@albert-mint20:~$ sudo apt-get update && sudo apt-get install -y apt-transport-https

Setting up apt-transport-https (2.0.6) ...


albert@albert-mint20:~$ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
OK

albert@albert-mint20:~$ echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main



albert@albert-mint20:~$ 
albert@albert-mint20:~$ sudo apt-get update


Reading package lists... Done
albert@albert-mint20:~$ 
albert@albert-mint20:~$ 
albert@albert-mint20:~$ 


albert@albert-mint20:~$ sudo apt-get install -y kubectl

Preparing to unpack .../kubectl_1.23.0-00_amd64.deb ...
Unpacking kubectl (1.23.0-00) ...
Setting up kubectl (1.23.0-00) ...
albert@albert-mint20:~$ 


```






