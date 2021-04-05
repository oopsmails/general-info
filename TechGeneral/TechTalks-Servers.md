
# Tech Talks: Servers

## Why is express.js app almost always behind nginx or other web server?


- You can use nginx server to serve static content of your application instead of nodejs. As nginx is better at serving static content like html, css, js & image files than nodejs. And another thing is in case of crashing of any node service, you can show proper error pages using nginx.

- It's still about security. I've worked on several projects that runs node as direct front-end server (one of them is a load-balancer written in node replacing nginx). To be honest the tooling around Apache and Nginx is much more mature. There's WAF (web application firewall) plugins etc. ready for you to use. With node you either depend on npm modules or your own security savvy. 

