
minikube status

minikube start

minikube dashboard

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










