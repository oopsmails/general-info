
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


To get the the Git repo, there was a dedicated volume type for Git repositories, *gitRepo*. Unfortunately, this has been deprecated, and it’s now necessary to do that "manually". This is what allows *initContainer*:

*Init Containers are specialized Containers that run before app Containers and can contain utilities or setup scripts not present in an app image.*

I’ve already created a dedicated Git repo to store the configuration. To clone the repo **and** checkout the v1.0.0 tag in one command, the command-line is the following:

```
$ git clone --branch v1.0.0 https://github.com/exoscale-labs/config-mgmt-properties.git

```

That’s the command that needs to be executed in the initContainer. In the YAML configuration, this translates to:

```
initContainers:
- name: git-clone
  image: alpine/git:1.0.4
  command: ['/bin/sh', '-c']
  args: ['git clone --branch v1.0.0 https://github.com/exoscale-labs/config-mgmt-properties.git']

```

The next and final step is to create a shared volume between this container and the main one. It doesn’t require any feature e.g. persistence, since it will be only used during the application startup:

```
spec:
  containers:
  volumes:
  - name: config
    emptyDir: {}

```

To connect the init container to the volume, the above snippet needs to be tweaked a bit:

```
initContainers:
- name: git-clone
  image: alpine/git:1.0.4
  command: ['/bin/sh', '-c']
  args: ['git clone --branch v1.0.0 https://github.com/exoscale-labs/config-mgmt-properties.git && mv config-mgmt-properties/dev/* /config']
  volumeMounts:
  - name: config
    mountPath: /config

```

This also moves the content of the dev folder to the config path in the shared volume.

On the main container’s side:

```
- name: config-mgmt
  image: nfrankel/configmgmt:0.0.2-SNAPSHOT
  volumeMounts:
  - name: config
    mountPath: /config
    readOnly: true
  ports:
    - containerPort: 8080

```

Because Spring Boot apps browse the config folder for configuration files by default, no further configuration is required. When Kubernetes executes the deploy:

- it runs the git-clone init container In turn:
- it clones the remote repo 


and moves the dev folder content to the config file


- it starts the config-mgmt container that launches the Spring Boot app. At this point, the framework reads the config folder for configuration files.

### Parameterizing the command-line

While the above configuration snippet achieves everything that was required so far, there’s still one thing left that might be improved: **it’s not easy to locate the places to change either the environment or the version in the whole command.** The good thing is that it doesn’t require anything new. Let’s just add a *ConfigMap* and update the command to make use of it:

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: clone-props
  namespace: default
data:
  props.version: v1.0.0       # 1
  props.env: stg              # 2
---
spec:
  replicas: 1
  selector:
    matchLabels:
      app: config-mgmt
  template:
    metadata:
      labels:
        app: config-mgmt
    spec:
      containers:
      initContainers:
      - name: git-clone
        image: alpine/git:1.0.4
        command: ['/bin/sh', '-c']
        args: ['git clone --branch $(props.version) https://github.com/exoscale-labs/config-mgmt-properties.git && mv config-mgmt-properties/$(props.env)/* /config'] # 3
        volumeMounts:
        - name: config
          mountPath: /config
        envFrom:
          - configMapRef:
              name: clone-props
      volumes:
      - name: config
        emptyDir: {}

```

1. Create a props.version key
2. Create a props.env key
3. Use them in the command-line



At this point, it’s straightforward to change the version: just update the property’s value, and delete the pod. Kubernetes will start it again, with the updated config map.


## Conclusion

Kubernets provides different ways to pass configuration parameters to Dockerized applications. Spring Boot is a powerful framework built on top of the Spring that is able to use any of those configuration options. We described how to do that with profiles, with command-line parameters, with environment variables, with config maps, and with shared volumes.

To sum it up:

Pro | Con

Profiles | Spring native |	A new environment requires updating the application and rebuilding the image

Command-line parameters |	Externalized |	Need to override the Docker image entry-point

Environment variables |	Easy to setup |	Not consistent across related key-value pairs

Config map |	Kubernetes native |	No versioning

Shared volumes with Git |	The best money can buy |	Complex setup


The complete source code for this post is available on Github.

https://github.com/exoscale-labs/config-mgmt-springboot-kubernetes 


