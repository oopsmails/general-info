

## General Commands

minikube status

minikube start

minikube dashboard

minikube tunnel

alias kubectl="minikube kubectl --"

kubectl version -o json

- kube-config file (~/.kube/config)

kubectl config view

Use a service with type NodePort or LoadBalancer to make the service reachable outside the cluster. See the services and kubectl expose documentation.



https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/

kubectl get svc mockbackend-minikube

kubectl describe svc mockbackend-minikube

kubectl get ep mockbackend-minikube


kubectl create configmap nginxconfigmap --from-file=default.conf

kubectl delete deployments,svc my-nginx; kubectl create -f ./nginx-secure-app.yaml


https://developer.ibm.com/tutorials/debug-and-log-your-kubernetes-app/

kubectl get pods

kubectl get pods | grep mockbackend-minikube

minikube kubectl get pods | grep mockbackend-minikube

mockbackend-minikube-7b4c8d789d-dpcld

kubectl describe pod mockbackend-minikube-7b4c8d789d-dpcld

kubectl get events [--namespace=default]


- Get application logs using kubectl

kubectl logs <your-pod-name>
kubectl logs mockbackend-minikube-7b4c8d789d-dpcld



- Use a shell inside a running container

kubectl exec -it mockbackend-minikube-7b4c8d789d-dpcld -- /bin/bash

root@mockbackend-minikube-7b4c8d789d-dpcld:/tmp/logs/BackendMock# tail -f application.log 


## Using minikube docker-env

$ eval $(minikube docker-env)

The command minikube docker-env returns a set of Bash environment variable exports to configure your local environment to re-use the Docker daemon inside the Minikube instance.

Passing this output through eval causes bash to evaluate these exports and put them into effect.

You can review the specific commands which will be executed in your shell by omitting the evaluation step and running minikube docker-env directly. However, this will not perform the configuration – the output needs to be evaluated for that.

This is a workflow optimization intended to improve your experience with building and running Docker images which you can run inside the minikube environment. It is not mandatory that you re-use minikube's Docker daemon to use minikube effectively, but doing so will significantly improve the speed of your code-build-test cycle.

In a normal workflow, you would have a separate Docker registry on your host machine to that in minikube, which necessitates the following process to build and run a Docker image inside minikube:

1. Build the Docker image on the host machine.
2. Re-tag the built image in your local machine's image registry with a remote registry or that of the minikube instance.
3. Push the image to the remote registry or minikube.
4. (If using a remote registry) Configure minikube with the appropriate permissions to pull images from the registry.
5. Set up your deployment in minikube to use the image.

By re-using the Docker registry inside Minikube, this becomes:

1. Build the Docker image using Minikube's Docker instance. This pushes the image to Minikube's Docker registry.
2. Set up your deployment in minikube to use the image.

More details of the purpose can be found in the minikube docs.






