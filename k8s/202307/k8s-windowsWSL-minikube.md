# Minikube on Windows WSL

Step 1: Install Docker on Windows

Step 2: Install minikube on Windows

Then, you just need to install minikube on Windows.

Nothing is simpler! Follow this link to install it on your computer.

https://minikube.sigs.k8s.io/docs/start/

Configure WSL to access minikube
To easily access minikube on the Windows side, we can create small script at location /usr/local/bin/minikube with the following contents:

```
#!/bin/sh
/mnt/c/Program\ Files/Kubernetes/Minikube/minikube.exe $@
```

Step 3: Install kubectl on WSL (Ubuntu)
To access and execute commands to our Kubernetes cluster created by minikube, we need a CLI tool to do so.

The tool that we’re going to want to use is called kubectl. This is industry standard!

Follow this link to install kubectl.
https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

Please note that this installation will happen on WSL with Ubuntu and not on the Windows side.

## Refs:

https://carmencincotti.com/2023-03-06/how-to-use-kubernetes-for-free-on-wsl/#step-2-install-minikube-on-windows
