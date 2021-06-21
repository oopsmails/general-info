
# Scaling In Azure App Service

- Ref:
https://www.c-sharpcorner.com/article/scaling-in-azure-app-service-almost-all-you-need-to-know/

## Scaling Options: Scale-Up vs. Scale-Out 

### Scale-Out (Horizontal scaling)

- It is basically adding multiple instances of the application that runs in your app. In other words, it increases the number of VM instances up to 30 depending upon your pricing tier. 

- We can do a scale-out count manually or set it to auto-scaling based on some rules.

- *Autoscale is a built-in feature that helps applications perform their best when demand changes. You can choose to scale your resource manually to a specific instance count, or via a custom Autoscale policy that scales based on metric(s) thresholds, or schedule instance count which scales during designated time windows. Autoscale enables your resource to be performant and cost-effective by adding and removing instances based on demand.*

### Scale-up (Vertical scaling)

- Dev/Test: F1 (free one), D1, B1, B2, and B3

F1: No feature; Share Infrastructure 1GB Memory/1GB Storage; 60 minutes/day compute
D1: Custom domain feature; Share Infrastructure 1GB Memory; 240 minutes/day compute
Bx: Custom domains/SSL; Manual Scaling up to 3 instances

- Prod: Standard Service Plan, Premium Service Plan
Standard Service Plan: Auto Scale up to 10 instances; 5 Staging Slots; 10 times daily backup
Premium Service Plan: Auto Scale up to 20 instances; 20 Staging Slots; 50 times daily backup

- Isolated Service Plan
This service plan is specifically considered for mission-critical workloads, that are required to operate in a virtual network. An ASE is a powerful feature offering of Azure App Service that gives network isolation and improved scale capabilities. This service plan enables consumers to run their applications in private, dedicated environments in Azure datacenter using Dv2-series VMs, which is also called as App Service Environment. The plan can scale to 100 instances with more available upon request.


