
# Azure General Knowledge

## Examples

https://nicolgit.github.io/how-deploy-angular-app-to-azure-appservice-running-linux-from-github/

https://devblogs.microsoft.com/premier-developer/how-to-deploy-angular-app-to-azure-app-service-running-linux-from-github/

## My Azure

https://springboot-employee.azurewebsites.net/employee-api

https://springboot-employee.azurewebsites.net/ping

## Terms

### Scale up vs Scale out

- Refs:

https://www.c-sharpcorner.com/article/scaling-in-azure-app-service-almost-all-you-need-to-know/

- "Scale up" means upgrade the capacity of the host where the app is hosted. Ex: Increase the memory from 1.75GB to 3.5GB.

- "Scale out" means upgrade the capacity of the app by increasing the number of host instances.

- It is basically adding multiple instances of the application that runs in your app. In other words, it increases the number of VM instances up to 30 depending upon your pricing tier. However, in an Isolated tier, we can further scale up to 100 instances based on our requirements. Additionally, we can do a scale-out count manually or set it to auto-scaling based on some rules.

