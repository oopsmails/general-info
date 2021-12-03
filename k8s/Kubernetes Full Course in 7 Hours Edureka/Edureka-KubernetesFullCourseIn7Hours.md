
# Edureka-KubernetesFullCourseIn7Hours-19.54

- Ref:

https://www.youtube.com/watch?v=0j-iIW3_sbg

## Installation on Ubuntu

### Start from 30:58

sudo apt-get update -y
sudo apt-get install curl

31:59
sudo apt-get install http ...

32:55
sudo apt-get install virtualbox virtualbox-ext

40:51 minikube

42:39
sudo minikube start

44:12
sudo minikube dashboard

45:33
sudo docker pull ubuntu
sudo docker run -lt -d ubuntu

48:28 Kubernates vs Docker?
52:37 Load balancing


56:53 CKA certification ... skip

59:49 Kubernates
1:02:28 why kubernates
1:05:36 minikube, EKS, AKS, GKS ...

1:09:19 Kubernetes Cluster, minikube vs kubeadm

1:22:04 plan to install kubernetes ... will continue watching first before setup my own plan!


1:27:29 install docker

https://alibaba-cloud.medium.com/how-to-install-and-deploy-kubernetes-on-ubuntu-16-04-6769fd1646db

swapoff -a

apt-get install apt-transport-https ca-certificates curl software-properties-common -y


1:31:17 install kubernetes
1:32:33 showing installed, kubernetes-cni, socat, kubelet, kubectl, kubeadm

kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=192.168.0.103


1:40:30 ....

