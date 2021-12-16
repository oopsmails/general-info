

https://www.udemy.com/kubernetes-microservices/?couponCode=RCK8S_YT


https://192.168.99.100:30000

minikube ip

https://192.168.99.101:30000/


--> install Docker Toolbox

--> install kubectl

https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-windows

Download the latest release v1.15.0 from this link.

kubectl version

--> install minikube

Install Minikube via direct download
To install Minikube manually on Windows, download minikube-windows-amd64, rename it to minikube.exe, and add it to your path.



minikube start 
minikube start --vm-driver="hyperv" --hyperv-virtual-switch="switch", 


I started the HyperV manager--->Virtual Switch Manager and created a new Private Switch. Use the name of the switch you created in the place of "switch". I got rid of the old error but i'm stuck with a new one - 
$ minikube start --vm-driver="hyperv" --hyperv-virtual-switch="KubeSwitch"


--> sample output

$ minikube start
* minikube v1.2.0 on windows (amd64)
* Downloading Minikube ISO ...
 129.33 MB / 129.33 MB  100.00% 0ssss
* Creating virtualbox VM (CPUs=2, Memory=2048MB, Disk=20000MB) ...
* Found network options:
  - NO_PROXY=192.168.99.100
* Configuring environment for Kubernetes v1.15.0 on Docker 18.09.6
  - env NO_PROXY=192.168.99.100
* Downloading kubeadm v1.15.0
* Downloading kubelet v1.15.0
* Pulling images ...
* Launching Kubernetes ...
* Verifying: apiserver proxy etcd scheduler controller dns
* Done! kubectl is now configured to use "minikube"


$ kubectl version
Client Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.0", GitCommit:"e8462b5b5dc2584fdcd18e6bcfe9f1e4d970a529", GitTreeState:"clean", BuildDate:"2019-06-19T16:40:16Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"windows/amd64"}
Server Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.0", GitCommit:"e8462b5b5dc2584fdcd18e6bcfe9f1e4d970a529", GitTreeState:"clean", BuildDate:"2019-06-19T16:32:14Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}


--> 

minikube ip


--> Dashboard: Has to be run in Powershell, in GitBash, error: X kubectl proxy: proxy start: fork/exec kubectl.exe: %1 is not a valid Win32 application.

minikube dashboard

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/alternative/kubernetes-dashboard.yaml





docker run -ti -p 9080:80 nginx


http://192.168.99.100:9080/

--> PS C:\Github> docker build --rm -f angular-integration/Dockerfile -t angular-integration:v1 angular-integration


docker build --rm -f angular-integration/Dockerfile -t angular-integration:v1 angular-integration

--> Error: Node Sass does not yet support your current environment: Linux 64-bit with Unsupported runtime (72)

--npm uninstall node-sass
--npm install -g node-sass
--npm rebuild node-sass

resolved by: npm install -g yarn, then do yarn install
because, yarn will rebuild node-sass


-->
PS C:\Github\angular-integration> docker build --rm -f Dockerfile -t angular-integration:v1 .

--> nginx port is 80 in container
docker run --rm -d -p 4300:80 angular-integration:v1

docker tag angular-integration:v1 oopsmails/angular-integration:v1


docker login 


docker push oopsmails/angular-integration:v1


==============================================

docker run -it -v ${PWD}:/usr/src/app -p 4200:4200 angular-integration:v1

docker-vol
C:\docker-vol

docker build --rm -f Dockerfile_dev -t angular-integration-dev:v1 .

docker run -it -v /docker-vol:/usr/src/app -p 4301:4301 angular-integration-dev:v1


docker run -it -v /docker-vol:/usr/src/app -p 4301:4301 angular-integration-dev:v1



docker run -it -v docker-vol:/app -p 4301:4300 angular-integration-dev:v1

docker run -it --name adev -v docker-vol://app -p 4301:4300 angular-integration-dev:v1


===============================================



http://127.0.0.1:51178/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/#!/overview?namespace=default

http://192.168.99.100:9080/

https://github.com/HoussemDellai/demo-angular-app/blob/master/Dockerfile

https://www.udemy.com/kubernetes-microservices/?couponCode=RCK8S_YT

http://192.168.99.100:4300/example/todos

http://192.168.99.100:4300/
http://192.168.99.100:4301/

================================================

docker rm $(docker ps -a -q)


docker rmi $(docker images -q)

==================================================================




==========================================================================

#!/usr/bin/env bash
set -e

# Build app and api containers
docker-compose -f docker/docker-compose.dev.yml build

# Launch the db alone once and give it time to create db user and database
# This is a quickfix to avoid waiting for database to startup on first execution (more details [here](https://docs.docker.com/compose/startup-order/))
docker-compose -f docker/docker-compose.dev.yml up -d db
sleep 5
docker-compose -f docker/docker-compose.dev.yml stop db


==> 20190708:

You can also execute first the command docker-compose create in order to create the containers and then execute the docker-compose start.
docker-compose build creates the images from your docker-compose.yml file.


--docker-compose -f docker-compose.yml build
--docker-compose -f docker-compose.yml start

docker-compose -f docker-compose.yml up




kubectl run adev --image=angular-integration-dev:v1 --port=80 deployment "adev" created


PS C:\Users\liu> kubectl run adev --image=angular-integration-dev:v1 --port=80 deployment "adev" created
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/adev created


kubectl create secret docker-registry <name> --docker-server=DOCKER_REGISTRY_SERVER --docker-username=DOCKER_USER --docker-password=DOCKER_PASSWORD --docker-email=DOCKER_EMAIL


kubectl create secret docker-registry dockerhub-oopsmails --docker-server=https://hub.docker.com/ --docker-username=oopsmails --docker-password=xxxxxxx --docker-email=oopsmails@gmail.com



kubectl create -f ./kubedemo-namespace.yml

==> real
kubectl create -f ./kubedemo-pod.yml

--kubectl expose rc adev --type="LoadBalancer"

kubectl expose rc example --port=8765 --target-port=9376 \
        --name=example-service --type=LoadBalancer


--kubectl -f ./kubedemo-service.yml

kubectl expose service nginx --port=443 --target-port=8443 --name=nginx-https

kubectl expose service adev-service --port=4444 --target-port=4301 --name=adev-service


kubectl --namespace=kubedemo expose deployment --port=8080 myvertx --type=LoadBalancer

kubectl expose deployment --port=4444 adev --type=LoadBalancer

kubectl expose deployment adev --port=4444 --target-port=8443 --type=LoadBalancer

kubectl expose deployment frontend --type=LoadBalancer

==> delete failed pod

PS C:\Github\angular-integration> kubectl get deployments
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
adev   0/1     1            0           6h48m
PS C:\Github\angular-integration>
PS C:\Github\angular-integration>
PS C:\Github\angular-integration> kubectl delete deployments adev
deployment.extensions "adev" deleted

kubectl delete pods adev

==> 

kubectl run adev --image=oopsmails/angular-integration:v1 --port=4301 --

kubectl expose deployment frontend --type=LoadBalancer







