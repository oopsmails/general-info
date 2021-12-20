
# Minikube on Linux Mint 20: Spring Boot Application

- Ref:

https://www.exoscale.com/syslog/configuration-management-kubernetes-spring-boot/

https://github.com/exoscale-labs/config-mgmt-springboot-kubernetes


- To learn configMap


## Run


[10.96.104.89](http://10.96.104.89:8080/)  

http://192.168.49.2:8080/ --> no  

http://192.168.49.2:30001/ --> working  


- Note: url not from *kubectl get svc*, but from *minikube ip*

```
albert@albert-mint20:~$ kubectl get svc
NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
config-mgmt-service          NodePort    10.111.223.84    <none>        8080:30001/TCP   17m
kubernetes                   ClusterIP   10.96.0.1        <none>        443/TCP          2d9h
mockbackend-minikube         NodePort    10.103.51.54     <none>        8888:31029/TCP   2d9h
nodejs-simple-rest-service   NodePort    10.103.204.114   <none>        3000:30132/TCP   39h
```


## Inspect docker image

- docker inspect oopsmails/mockbackend:v1

```
"Entrypoint": [
                "java",
                "-jar",
                "/spring-boot-mock-backend-1.0-SNAPSHOT.jar"
            ],
```


- docker inspect configmgmt:1.0.0

...
"Entrypoint": [
                "java",
                "-cp",
                "/app/resources:/app/classes:/app/libs/*",
                "com.exoscale.configmgmt.demo.DemoApplication"
            ],
...


## Run with Docker

Remember that the entry point is basically baked into the image, while arguments can be overwritten - and will be appended to the entry point. Hence, just append the relevant arguments and they will either be used as is, or overwrite existing ones, which is not the case here. To activate a profile e.g. dev, :


At this time, having *application-dev.yml* and *application-stg.yml* in src/main/resources

```
$ docker run -p8080:8080 nfrankel/configmgmt:0.0.1-SNAPSHOT --spring.profiles.active=dev


docker run -p8080:8080 configmgmt:1.0.0 --spring.profiles.active=dev
docker run -p8080:8080 configmgmt:1.0.0 --spring.profiles.active=stg

docker run -p8080:8080 configmgmt:1.0.0 --spring.config.location=your/config/dir/

-Dspring.config.location=your/config/dir/

docker rmi configmgmt:1.0.0
```

## Configuration management options with Kubernetes

eval $(minikube docker-env)

minikube image load configmgmt:1.0.0

## Manipulate Deployment

- 1.first-deploy.yml, showing "production" view, because there no *profile* set.

kubectl apply -f 1.first-deploy.yml

- 1.1.first-deploy-using-profile.yml, showing "dev" view, because *args: ["--spring.profiles.active=dev"]* is added.

kubectl apply -f 1.1.first-deploy-using-profile.yml

- 1.2.first-deploy-using-sys-properties.yml, showing "Pre-production" and "purple"

kubectl apply -f 1.2.first-deploy-using-sys-properties.yml

```
    spec:
      containers:
        - name: config-mgmt
          image: nfrankel/configmgmt:0.0.2-SNAPSHOT
          command:
            - "java"
            - "-Dapp.env.label=Pre-production"
            - "-Dapp.env.color=purple"
            - "-cp"
            - "/app/resources:/app/classes:/app/libs/*"
            - "com.exoscale.configmgmt.demo.DemoApplication"
```

- 1.3.first-deploy-using-env-variable.yml, showing "Training" and "blue"

kubectl apply -f 1.3.first-deploy-using-env-variable.yml

```
    spec:
      containers:
        - name: config-mgmt
          image: nfrankel/configmgmt:0.0.2-SNAPSHOT
          env:
            - name: app.env.label
              value: Training
            - name: app.env.color
              value: blue
```

## Using a dedicated configuration map

- 2.using-configMap.yml


```
    spec:
      containers:
        - name: config-mgmt
          image: configmgmt:1.0.0
          envFrom:            # <----------------------------------- Magic happens here
            - configMapRef:
                name: banner-config-preprod
          ports:
            - containerPort: 8080
```


kubectl apply -f 2.using-configMap.yml

http://192.168.49.2:30001/

- Testing around

Change *Config Maps* in dashboard, e.g, as below .... But, **note, need to delete pods (preferred because non-stop even with one pod) or restart *Deploymnet* (non-stop only if multiple pods) to see the change taking effect.**

Note that while ConfigMaps can be mounted on volumes attached to Pods, Kubernetes’ handling of the structure makes it incompatible for Spring Boot applications configuration.

So far, this is a great way to handle configuration. But how does it handle versioning?

## Using volumes

- kubectl apply -f 3.1.k8s-using-volume-policy-never.yml

kubectl apply -f 3.k8s-using-volume.yml <----------- also ok, without never because already run *minikube image load configmgmt:1.0.0 ...*

```
albert@albert-mint20:~/Documents/sharing/github/general-info/k8s/202201$ kubectl apply -f 3.k8s-using-volume.yml
deployment.apps/config-mgmt-deploy configured
configmap/clone-props created
service/config-mgmt-service unchanged
```

http://192.168.49.2:30001/

- Testing around

Change *Config Maps* in dashboard, e.g, as below .... But, **note, need to delete pods (preferred because non-stop even with one pod) or restart *Deploymnet* (non-stop only if multiple pods) to see the change taking effect.**

```
{
	"props.env": "dev",
	"props.version": "v1.0.0"
}
```


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



kubectl exec -it config-mgmt-deploy-5777c69759-n69fw -- /bin/bash

- when to re-apply

Back-off restarting failed container


- This git command is NOT working. This is the root reason of "Back-off restarting failed container"

In events of Pod, actually stopped at "Started container git-clone ..."

- Try this: NOT working!

git clone --branch v2.0.0 https://github.com/oopsmails/k8s-springboot-app-demo-config.git

- So, this is NOT working!

"git clone --branch $(props.version) https://github.com/oopsmails/k8s-springboot-app-demo-config.git && mv config-mgmt-properties/$(props.env)/* /config",

- Try this: working

git clone https://github.com/oopsmails/k8s-springboot-app-demo-config.git k8s-springboot-app-demo-config-v1.0.0

- This is ok

"git clone https://github.com/oopsmails/k8s-springboot-app-demo-config.git k8s-springboot-app-demo-config-$(props.version) && mv k8s-springboot-app-demo-config-$(props.version)/$(props.env)/* /config",

- 1.1 When having "Back-off restarting failed container" problem for some reason again

We can use *2.using-configMap.yml* to deploy again and try around.

And, then, "EDIT" to change using *3.2.k8s-debugging-using-volume-policy-never.yml*, then eveything is OK again.

- 1.2 When having "Back-off restarting failed container" problem for some reason again

Delete Deployment, make sure pods were also deleted. Restart minikube and reploy with *3.2.k8s-debugging-using-volume-policy-never.yml*.

It's like "clearing cache".?






```

Events

Successfully assigned default/config-mgmt-deploy-b4f85dd4-fddcl to minikube

Container image "alpine/git:1.0.4" already present on machine
kubelet minikube
spec.initContainers{git-clone}

Created container git-clone
kubelet minikube
spec.initContainers{git-clone}

Started container git-clone
kubelet minikube
spec.initContainers{git-clone}

Container image "configmgmt:1.0.0" already present on machine
kubelet minikube
spec.containers{config-mgmt}

Created container config-mgmt
kubelet minikube
spec.containers{config-mgmt}

Started container config-mgmt
kubelet minikube
spec.containers{config-mgmt}

```

