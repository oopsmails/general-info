
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





