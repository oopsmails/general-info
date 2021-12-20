
- Pod

```

albert@albert-mint20:~$ kubectl describe pod config-mgmt-deploy-b4f85dd4-qzjd7
Name:         config-mgmt-deploy-b4f85dd4-qzjd7
Namespace:    default
Priority:     0
Node:         minikube/192.168.49.2
Start Time:   Sun, 19 Dec 2021 21:44:22 -0500
Labels:       app=config-mgmt
              pod-template-hash=b4f85dd4
Annotations:  <none>
Status:       Running
IP:           172.17.0.2
IPs:
  IP:           172.17.0.2
Controlled By:  ReplicaSet/config-mgmt-deploy-b4f85dd4
Init Containers:
  git-clone:
    Container ID:  docker://ce938078aaad25b0b97fb44c3aee4debc4a20d7a6bf9946b6e760fd4a2093822
    Image:         alpine/git:1.0.4
    Image ID:      docker-pullable://alpine/git@sha256:94e7d5791a8dcd3a4d45ea6d89b03d1004f8ee02c34c6124f1b6d269e8a312e0
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/sh
      -c
    Args:
      git clone https://github.com/oopsmails/k8s-springboot-app-demo-config.git k8s-springboot-app-demo-config-$(props.version) && mv k8s-springboot-app-demo-config-$(props.version)/$(props.env)/* /config
    State:          Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Sun, 19 Dec 2021 21:50:29 -0500
      Finished:     Sun, 19 Dec 2021 21:50:30 -0500
    Ready:          True
    Restart Count:  3
    Environment Variables from:
      clone-props  ConfigMap  Optional: false
    Environment:   <none>
    Mounts:
      /config from config (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-jrnmk (ro)
Containers:
  config-mgmt:
    Container ID:   docker://007c2d254bf83be5db0a66d3d632c7030978d71c13078359abf099f76023cb6b
    Image:          configmgmt:1.0.0
    Image ID:       docker://sha256:2a5a5aa2d17c11b9322831a257c3854af4f84e5cf3729e661f8ce997714a7e2e
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sun, 19 Dec 2021 21:50:30 -0500
    Last State:     Terminated
      Reason:       Error
      Exit Code:    143
      Started:      Sun, 19 Dec 2021 21:44:24 -0500
      Finished:     Sun, 19 Dec 2021 21:48:53 -0500
    Ready:          True
    Restart Count:  1
    Environment:    <none>
    Mounts:
      /config from config (ro)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-jrnmk (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  config:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-jrnmk:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason          Age                   From               Message
  ----     ------          ----                  ----               -------
  Normal   Scheduled       9m22s                 default-scheduler  Successfully assigned default/config-mgmt-deploy-b4f85dd4-qzjd7 to minikube
  Normal   Pulled          9m22s                 kubelet            Container image "alpine/git:1.0.4" already present on machine
  Normal   Created         9m22s                 kubelet            Created container git-clone
  Normal   Started         9m22s                 kubelet            Started container git-clone
  Normal   Pulled          9m20s                 kubelet            Container image "configmgmt:1.0.0" already present on machine
  Normal   Created         9m20s                 kubelet            Created container config-mgmt
  Normal   Started         9m20s                 kubelet            Started container config-mgmt
  Normal   SandboxChanged  4m8s                  kubelet            Pod sandbox changed, it will be killed and re-created.
  Warning  BackOff         3m29s (x3 over 4m)    kubelet            Back-off restarting failed container
  Normal   Pulled          3m15s (x3 over 4m7s)  kubelet            Container image "alpine/git:1.0.4" already present on machine
  Normal   Created         3m15s (x3 over 4m7s)  kubelet            Created container git-clone
  Normal   Started         3m15s (x3 over 4m6s)  kubelet            Started container git-clone
  Normal   Pulled          3m14s                 kubelet            Container image "configmgmt:1.0.0" already present on machine
  Normal   Created         3m14s                 kubelet            Created container config-mgmt
  Normal   Started         3m14s                 kubelet            Started container config-mgmt

```

- Deployment

```
albert@albert-mint20:~$ kubectl describe deployment config-mgmt-deploy
Name:                   config-mgmt-deploy
Namespace:              default
CreationTimestamp:      Sun, 19 Dec 2021 21:39:21 -0500
Labels:                 app=config-mgmt
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=config-mgmt
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=config-mgmt
  Init Containers:
   git-clone:
    Image:      alpine/git:1.0.4
    Port:       <none>
    Host Port:  <none>
    Command:
      /bin/sh
      -c
    Args:
      git clone https://github.com/oopsmails/k8s-springboot-app-demo-config.git k8s-springboot-app-demo-config-$(props.version) && mv k8s-springboot-app-demo-config-$(props.version)/$(props.env)/* /config
    Environment Variables from:
      clone-props  ConfigMap  Optional: false
    Environment:   <none>
    Mounts:
      /config from config (rw)
  Containers:
   config-mgmt:
    Image:        configmgmt:1.0.0
    Port:         8080/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:
      /config from config (ro)
  Volumes:
   config:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Progressing    True    NewReplicaSetAvailable
  Available      True    MinimumReplicasAvailable
OldReplicaSets:  <none>
NewReplicaSet:   config-mgmt-deploy-b4f85dd4 (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------

```



