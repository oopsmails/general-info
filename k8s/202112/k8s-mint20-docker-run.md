

### Run with docker

- Dockerfile with bash installed
- Try volume, need to create */dockerv* on local first, chown and chmod, if *touch text.txt* in */nodejsapp* in container, then will see it in */dockerv/nodejs-simple-rest* on local.
- Try 2000 on local instead of 3000
- Try /bin/bash, 

docker run -it -d -p 2000:3000 oopsmails/nodejs-simple-rest:v1

docker run --rm --name nodejs-simple-rest -d -p 2000:3000 oopsmails/nodejs-simple-rest:v1

- will not start if not with *bash* installed, see error without *-d*, "Error: Cannot find module '/bin/bash'"

docker run -it --rm --name nodejs-simple-rest -d -p 2000:3000 oopsmails/nodejs-simple-rest:v1
docker run -it --rm --name nodejs-simple-rest -d -p 2000:3000 oopsmails/nodejs-simple-rest:v1 /bin/bash


- volume should not use *WORKDIR /nodejsapp*, otherwise, may causing error, "no package.json"

docker run -it --rm --name nodejs-simple-rest -v /dockerv/nodejs-simple-rest:/dockerv-inside -d -p 2000:3000 oopsmails/nodejs-simple-rest:v1

- For some reason, this without *-d* but with */bin/bash* not working!!!
docker run -it --rm --name nodejs-simple-rest -v /dockerv/nodejs-simple-rest:/dockerv-inside -p 2000:3000 oopsmails/nodejs-simple-rest:v1 /bin/bash

- delete container

docker rm -f nodejs-simple-rest

