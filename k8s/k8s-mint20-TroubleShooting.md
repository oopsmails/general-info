
#  Trouble Shooting on localhost:8080 was refused

- Ref:

https://discuss.kubernetes.io/t/the-connection-to-the-server-localhost-8080-was-refused-did-you-specify-the-right-host-or-port/1464/5

## Check if there is no contexts are configured.


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



## further, not try because need to configure contexts 

- Run these commands to fix it.

sudo cp /etc/kubernetes/admin.conf HOME/ sudo chown (id -u):$(id -g) $HOME/admin.conf
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






