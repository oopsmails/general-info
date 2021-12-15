
# How to Install Kubectl on Linux Mint 20

LOG:

- 20211215: 

## Install Kubectl on Linux Mint 20: 20211215

- Ref:

https://linuxways.net/mint/how-to-install-kubectl-on-linux-mint-20/


### Install all the Required Packages and Dependencies

sudo apt-get install -y apt-transport-https ca-certificates curl

#### Download the Relevant Public Key:

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

#### Add the Kubernetes Repository to your System:

```
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

```
albert@albert-mint20:~$ sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

albert@albert-mint20:~$ 
albert@albert-mint20:~$ 
albert@albert-mint20:~$ echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main

```

#### Fix all the Broken Links and Dependencies:

sudo apt-get update

#### Install Kubectl on your System:

sudo apt-get install -y kubectl

#### Inquire the Version of Kubectl on your System:

```
kubectl version

kubectl version -o json


albert@albert-mint20:~$ kubectl version
Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.0", GitCommit:"ab69524f795c42094a6630298ff53f3c3ebab7f4", GitTreeState:"clean", BuildDate:"2021-12-07T18:16:20Z", GoVersion:"go1.17.3", Compiler:"gc", Platform:"linux/amd64"}
The connection to the server localhost:8080 was refused - did you specify the right host or port?

---> see trouble shooting for 8080


```

- After install minikube, see k8s-mint20-minikube.md

```

albert@albert-mint20:~$ kubectl version -o json
{
  "clientVersion": {
    "major": "1",
    "minor": "23",
    "gitVersion": "v1.23.0",
    "gitCommit": "ab69524f795c42094a6630298ff53f3c3ebab7f4",
    "gitTreeState": "clean",
    "buildDate": "2021-12-07T18:16:20Z",
    "goVersion": "go1.17.3",
    "compiler": "gc",
    "platform": "linux/amd64"
  },
  "serverVersion": {
    "major": "1",
    "minor": "22",
    "gitVersion": "v1.22.3",
    "gitCommit": "c92036820499fedefec0f847e2054d824aea6cd1",
    "gitTreeState": "clean",
    "buildDate": "2021-10-27T18:35:25Z",
    "goVersion": "go1.16.9",
    "compiler": "gc",
    "platform": "linux/amd64"
  }
}
```


### Remove Kubectl from Linux Mint 20

#### Remove Kubectl from your System:

sudo apt-get purge --autoremove kubectl


#### Remove all the Extra Installed Packages and Dependencies from your System

sudo apt-get purge --autoremove apt-transport-https ca-certificates curl



## How To Install Kubernetes Dashboard with NodePort: 20211215


- Ref:

https://computingforgeeks.com/manage-multiple-kubernetes-clusters-with-kubectl-kubectx/ 

https://computingforgeeks.com/how-to-install-kubernetes-dashboard-with-nodeport/


### Install and Config kubectl on Linux 

#### Install kubectl on Linux

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl


```

```
$ kubectl version
Client Version: version.Info{Major:"1", Minor:"22", GitVersion:"v1.22.2", GitCommit:"8b5a19147530eaac9476b0ab82980b4088bbc1b2", GitTreeState:"clean", BuildDate:"2021-09-15T21:38:50Z", GoVersion:"go1.16.8", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"22", GitVersion:"v1.22.2", GitCommit:"8b5a19147530eaac9476b0ab82980b4088bbc1b2", GitTreeState:"clean", BuildDate:"2021-09-15T21:32:41Z", GoVersion:"go1.16.8", Compiler:"gc", Platform:"linux/amd64"}
```

#### Configure Kubectl

The kubectl tool looks for a file named config in the $HOME/.kube directory, but a separate file can be specified using --kubeconfig option. The kubeconfig files helps you to organize information about clusters, users, namespaces, and authentication mechanisms

```
$ ls $HOME/.kube/config
/home/jmutai/.kube/config

```

In this configuration you need to set the following elements:

- clusters – To configure access to a cluster, you need to know the location of the cluster and have credentials to access it. In the cluster section, you’ll set certificate-authority-data, access URL and the name for your cluster.


- context: A context element is used to group access parameters under a convenient name. Each context in the configuration file should have hree parameters: cluster, namespace, and user.


- users: Specify used to access and its credentials.


**Two configuration types:**

- For a single cluster, your configuration file will look similar to below ... this is one machine cluster, Minikube

```
$ ls $HOME/.kube/config
/home/jmutai/.kube/config

cat .kube/config

```

- Kubectl configuration for multiple clusters .... multiple machines cluster, Kubeadm


```
$HOME/.kube/config

```

#### Switching between contexts with kubectl

- View current contexts:

```
kubectl config get-contexts
```

- To switch to a different context, use:

```
$ kubectl config use-context k8s-prod
Switched to context "k8s-prod".

$ kubectl config use-context k8s-staging
Switched to context "k8s-staging".
```

- Get nodes

```
kubectl get nodes
```

#### Easy Context and Namespace switching with kubectx and kubens

kubectx helps you switch between clusters back and forth and and kubens helps you switch between Kubernetes namespaces smoothly:


- Install kubectx and kubens

wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
chmod +x kubectx kubens
sudo mv kubens kubectx /usr/local/bin

- Commands examples

```
# Get all contexts
$ kubectx
k8s-dev 
k8s-staging
k8s-qa
k8s-prod

# Switch to prod context
$ kubectx k8s-prod

# Get all namespaces in  k8s-prod context
$ kubens

# Switch to a namespace
$ kubens <namespacename>

```

