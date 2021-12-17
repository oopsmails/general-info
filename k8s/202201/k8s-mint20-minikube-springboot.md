
# Minikube on Linux Mint 20: Spring Boot Application

- Ref:

https://www.exoscale.com/syslog/configuration-management-kubernetes-spring-boot/

https://github.com/exoscale-labs/config-mgmt-springboot-kubernetes


- To learn configMap


## Inspect docker image

docker inspect oopsmails/mockbackend:v1


## Configuration management options with Kubernetes

eval $(minikube docker-env)


## Manipulate Deployment

1.first-deploy.yml, showing "production" view

1.1.first-deploy-using-profile.yml, showing "dev" view, because *args: ["--spring.profiles.active=dev"]* is added.

1.2.first-deploy-using-sys-properties.yml

1.3.first-deploy-using-env-variable.yml

## Using a dedicated configuration map

2.using-configMap.yml


Note that while ConfigMaps can be mounted on volumes attached to Pods, Kubernetes’ handling of the structure makes it incompatible for Spring Boot applications configuration.

So far, this is a great way to handle configuration. But how does it handle versioning?

## Using volumes

Imagine a new requirement popping-up to change the pre-production banner color from purple to red. If it were a business requirement, it would need to be versioned, with a relevant commit message. The exact same standard should apply to configuration changes as to code changes: this is one of the tenants of Infrastructure-as-Code.

While there are a lot of tools dedicated to configuration management (Ansible, Puppet, Chef, etc.), it’s possible to handle the versioning of this change without any additional infrastructure component with Kubernetes. It includes two steps:

- Getting the Git repo where the configuration is located
- Making that repo available to the main container




