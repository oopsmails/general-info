
#  Knowledges

## NodePort vs. LoadBalancer vs. Ingress

- Ref:

https://platform9.com/blog/understanding-kubernetes-loadbalancer-vs-nodeport-vs-ingress/


NodePort wins on simplicity, but you need to open firewall rules to allow access to ports 30,000 to 32,767, and know the IPs of the individual worker nodes.

LoadBalancer when on a public cloud, or supported by MetalLB, works great with the service being able to control the exact port it wants to use. The downside is it can get expensive, as every service will get its own load balancer and external IP, which cost $$$ on the public cloud.

Ingress is becoming the most commonly used, combined with the load balancer service; especially with MetalLB now available, as it minimizes the number of IPs being used while still allowing for every service to have its own name and/or URI routing.

- Enable LoadBalancer and external IP

https://minikube.sigs.k8s.io/docs/handbook/accessing/

Run tunnel in a separate terminal
it will ask for password.

minikube tunnel
minikube tunnel runs as a process, creating a network route on the host to the service CIDR of the cluster using the cluster’s IP address as a gateway. The tunnel command exposes the external IP directly to any program running on the host operating system.

