
# Try Kubernetes on MacOS:

- MacOS:

## Setting up Kubernetes Dashboard

http://collabnix.com/kubernetes-dashboard-on-docker-desktop-for-windows-2-0-0-3-in-2-minutes/

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

-> Not working:
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml


kubectl proxy &

http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/


Alberts-Mac:staging albert$ curl http://localhost:8001/api
{
  "kind": "APIVersions",
  "versions": [
    "v1"
  ],
  "serverAddressByClientCIDRs": [
    {
      "clientCIDR": "0.0.0.0/0",
      "serverAddress": "192.168.65.3:6443"
    }
  ]
}

http://:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/


$TOKEN=((kubectl -n kube-system describe secret default | Select-String "token:") -split " +")[1]
-> error:
```
Alberts-Mac:staging albert$ $TOKEN=((kubectl -n kube-system describe secret default | Select-String "token:") -split " +")[1]
-bash: syntax error near unexpected token `('
Alberts-Mac:staging albert$ kubectl -n kube-system describe secret default
Name:         default-token-bgwmg
Namespace:    kube-system
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: default
              kubernetes.io/service-account.uid: 866cbc75-f46b-11e9-b28b-025000000001

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1025 bytes
namespace:  11 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJkZWZhdWx0LXRva2VuLWJnd21nIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImRlZmF1bHQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI4NjZjYmM3NS1mNDZiLTExZTktYjI4Yi0wMjUwMDAwMDAwMDEiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06ZGVmYXVsdCJ9.lxAWdt6ZYWJskPVLTrVkVrePV6FBuTh8het25DOYjPcTvhFdGskg8sz6bHzFx6HWEDPcT1727eIVM7qulkbMDWXH3lJVai8Ym1s8a8VP8Mi3Gm5A7LFjhs8E8iAijj2uHhvhutLcVyxyNNOg1oax9JQGTCgYyRSSl8T96k5Fc3BDY9OjpbvdISDzjOI6wsMukd7QH808kZBHkqkg_ZO8bRV929-5pqUMu270ko4ryojzjhbWw8v_-x072-DltZV-2RclXewiA7Tawy64AAxTE8JcVxZeqy9Kig5DX39X_FBhzzsNmvBVKpEaOD6wSmxrd8neF7svkj3YNaNeGHAhbg
```

eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJkZWZhdWx0LXRva2VuLWJnd21nIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImRlZmF1bHQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI4NjZjYmM3NS1mNDZiLTExZTktYjI4Yi0wMjUwMDAwMDAwMDEiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06ZGVmYXVsdCJ9.lxAWdt6ZYWJskPVLTrVkVrePV6FBuTh8het25DOYjPcTvhFdGskg8sz6bHzFx6HWEDPcT1727eIVM7qulkbMDWXH3lJVai8Ym1s8a8VP8Mi3Gm5A7LFjhs8E8iAijj2uHhvhutLcVyxyNNOg1oax9JQGTCgYyRSSl8T96k5Fc3BDY9OjpbvdISDzjOI6wsMukd7QH808kZBHkqkg_ZO8bRV929-5pqUMu270ko4ryojzjhbWw8v_-x072-DltZV-2RclXewiA7Tawy64AAxTE8JcVxZeqy9Kig5DX39X_FBhzzsNmvBVKpEaOD6wSmxrd8neF7svkj3YNaNeGHAhbg

kubectl config set-credentials docker-for-desktop --token="${TOKEN}"

Click on Kubeconfig and select the “config” file under C:\Users<Username>.kube\config


$TOKEN=((kubectl -n kube-system describe secret default | Out-String -stream | Select-String "token:") -split " +")[1]

kubectl -n kube-system describe secret default | Out-String -stream | Select-String "token:"

(kubectl -n kube-system describe secret default) | Select-String "token:"


## Build image v1 and deploy to Kubernetes:


### build image
```
cd /Users/albert/Documents/docker/staging

docker build --rm -f /Users/albert/Documents/github/nodejs-simple-rest/Dockerfile -t nodejs-simple-rest:v1 /Users/albert/Documents/github/nodejs-simple-rest
```

### Run the v1 image locally to test.

`docker run --rm --name nodejs-simple-rest -d -p 3000:3000 nodejs-simple-rest:v1`

http://192.168.232.128:3000/api

### Tag the image before uploading, here to DockerHub

`docker tag nodejs-simple-rest:v1 oopsmails/nodejs-simple-rest:v1`

### Upload to DockerHub
```
docker login 

docker push oopsmails/nodejs-simple-rest:v1

```

### Kubernetes: Create deployment.yaml

`kubectl apply -f nodejs-simple-rest-deployment.yaml`

### Kubernetes: Create service.yaml
```
kubectl apply -f nodejs-simple-rest-service.yaml <---- not using nodeport
kubectl apply -f nodejs-simple-rest-service-loadbalancer.yaml
```

http://localhost:3000/api


## Build image v2 and deploy to Kubernetes by using rolling technique:

### make change to application and then build image v2.0
```
docker build --rm -f nodejs-simple-rest/Dockerfile -t nodejs-simple-rest:v2 nodejs-simple-rest
docker build --rm -f /Users/albert/Documents/github/nodejs-simple-rest/Dockerfile -t nodejs-simple-rest:v2 /Users/albert/Documents/github/nodejs-simple-rest
```

### run locally for testing
`docker run --rm --name nodejs-simple-rest -d -p 3000:3000 nodejs-simple-rest:v2`

-> error: docker: Error response from daemon: driver failed programming external connectivity on endpoint nodejs-simple-rest (c39d6bbed984a362d7c86dacfc3731881b043ce5c107fee10cb15a125bb4fac2): Error starting userland proxy: listen tcp 0.0.0.0:3000: bind: address already in use.

because kubernetes "nodejs-simple-rest-service" service is using port 3000, delete the service to test v2, before doing that, may need to set "nodejs-simple-rest-deployment" scale as 0, otherwise, need to change port back and forth.
Then run again.

### tag as v2
`docker tag nodejs-simple-rest:v2 oopsmails/nodejs-simple-rest:v2`

### push to docker hub
`docker push oopsmails/nodejs-simple-rest:v2`

### run locally (not on Kubernetes for testing purpose)
`docker run --rm --name nodejs-simple-rest -d -p 3000:3000 oopsmails/nodejs-simple-rest:v2`

### rolling up to v2 in kubernetes:

- set "nodejs-simple-rest-deployment" scale as 2, 

`kubectl apply -f nodejs-simple-rest-service-loadbalancer.yaml`

try: http://192.168.232.128:3000/api, still showing "v1", because still using image v1

- rolling up:

revise version and replicas in "nodejs-simple-rest-deployment-rolling.yaml" as necessary

`kubectl apply -f nodejs-simple-rest-deployment-rolling.yaml`

wait for a while, refresh dashboard to see the rolling process ....

http://192.168.232.128:3000/api

will see "v2"







