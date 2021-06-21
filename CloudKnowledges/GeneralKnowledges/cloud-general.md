# General Knowledge About Cloud

## Dockerize or Containerize Applications

### nginx gateway angular


https://stackoverflow.com/questions/65860011/docker-nginx-angular-spring-boot

https://github.com/mithilwane/DockerTryouts


https://stackoverflow.com/questions/45717835/docker-proxy-pass-to-another-container-nginx-host-not-found-in-upstream


### rootless Dockerfile


## Reverse Proxy vs. Load Balancer

Ref:
https://www.nginx.com/resources/glossary/reverse-proxy-vs-load-balancer/

- A reverse proxy accepts a request from a client, forwards it to a server that can fulfill it, and returns the server’s response to the client.

- A load balancer distributes incoming client requests among a group of servers, in each case returning the response from the selected server to the appropriate client.

## Application Load Balancer(ALB) VS API Gateway

- Ref: https://dashbird.io/blog/aws-api-gateway-vs-application-load-balancer/

### Concepts
For Serverless applications, API Gateway was the only way to go until recently, when AWS announced the integration of ALB with Lambda functions.

Apart from Lambda functions, ALB can route requests to EC2 instances, ECS containers, and IP addresses. It also integrates with AWS Cognito for user authentication and authorization purposes.

API Gateway, on the other hand, is much better integrated with AWS’s managed services. Apart from Lambda functions, it can also integrate with virtually any other service that is available through HTTP requests, such as DynamoDB tables, SQS queues, S3 buckets, etc. Even external HTTP endpoints hosted outside of AWS can be integrated through HTTP.

### Request Routing Capabilities

API Gateway supports path-based routing. In other words, developers can configure which resources will receive incoming API requests based on the URL requested by the client.

ALB, on the other hand, offers a rule-based routing mechanism. Apart from supporting a URL path-based approach similarly to API Gateway, it also provides:

- Requester Hostname
- Requester IP address (CIDR blocks)
- HTTP Headers
- HTTP Request method (POST, GET, etc)
- Key/value pairs incoming as query strings




