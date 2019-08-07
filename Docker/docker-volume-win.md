
--> working

docker run --name myjenkins -p 9090:8080 -p 50000:50000 -v //dockerv/jenkins:/var/jenkins_home jenkins



docker run -it -p 2000:3000 -v ${pwd}:/app example-app


docker run -it -p 2000:3000 -v ${pwd}:/app nodejs-simple-rest-deployment


docker run --rm --name nodejs-simple-rest2 -d -p 2000:3000 nodejs-simple-rest:v2


docker run -it --rm -p 2000:3000 --mount 'type=bind, source="C:\GithubStaging\nodejs-simple-rest", target="c:/app"' --name nodejs-simple-rest2 nodejs-simple-rest:v2


docker run -it --rm -p 2000:3000 --mount 'type=bind, source="%cwd%", target="c:/app"' --name nodejs-simple-rest2 nodejs-simple-rest:v2


docker run -it --rm -p 2000:3000 --mount 'type=bind, source="%cwd%", target="c:/app"' --name nodejs-simple-rest2 nodejs-simple-rest:v2

--> try further, https://nickjanetakis.com/blog/docker-tip-66-fixing-error-response-from-daemon-invalid-mode
docker run --rm --name nodejs-simple-rest2 -v c:/GithubStaging/nodejs-simple-rest:/app -p 2000:3000 nodejs-simple-rest:v2


=======================================

The -it runs Docker interactively (so you get a pseudo-TTY with STDIN). The --rm causes Docker to automatically remove the container when it exits.


https://stackoverflow.com/questions/50985298/volume-path-or-mount-in-windows-container


docker run -it -p 8001:80 --mount 'type=bind, source="D:\Projects\Docker\publish", target="c:/app"' --name docker-vol-test docker-vol

docker run -it -p 8001:80 --mount 'type=bind, source="%cwd%\publish", target="c:/app"' --name docker-vol-test docker-vol


docker create -t -i -v C:/GithubStaging/nodejs-simple-rest:/mnt/test nodejssimple /bin/bash

===================================================

- oracle vm virtualbox root password

default user is docker

To change root password:

sudo passwd root

su root





