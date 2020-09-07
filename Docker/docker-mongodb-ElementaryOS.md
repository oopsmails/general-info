https://phoenixnap.com/kb/docker-mongodb


# Download MongoDB Image for Docker

Follow the step-by-step instructions below to download the latest official MongoDB image for Docker.

Your Docker service needs to be active and running. You can quickly check the current status by entering the following command in your terminal:
sudo service docker status
In this example, the Docker service is active and running.

Terminal indicates that Docker is active and running.
Proceed to download the latest official Docker image for the MongoDB database:
sudo docker pull mongo
The image indicates that the system used the latest tag by default.

System installs the latest version of MongoDB.
To download a specific version of MongoDB, use the same command appended with the version tag. For example:

sudo docker pull mongo:4.2.2
List the images in your Docker repository with the following command:
sudo docker images
The interface confirms that the MongoDB image is now available.

List of Docker images confirms that MongoDB is available in the local repository.

# Deploy MongoDB Container

By default, MongoDB stores data in the /data/db directory within the Docker container. To remedy this, mount a directory from the underlying host system to the container running the MongoDB database. This way, data is stored on your host system and is not going to be erased if a container instance fails.

Create a /mongodata directory on the host system:
sudo mkdir -p /mongodata
Start the Docker container with the run command using the mongo image. The /data/db directory in the container is mounted as /mongodata on the host. Additionally, this command changes the name of the container to mongodb:


sudo docker run -it -v mongodata:/data/db --name mongodb -d mongo
-it – Provides an interactive shell to the Docker container.

MongoDB container is successfully initiated.
-v – Use this option to attach the /mongodata host volume to the /data/db container volume.

-d – Starts the container as a background process.

--name – Name of the container.

Once the MongoDB server starts running in a container, check the status by typing:
sudo docker ps
The default port number is 27017, as can be seen in the output.

List of Docker images with default ports. The MongoDB port is listed as 27017.
Optionally you can specify the MongoDB port explicitly:
sudo docker run -it -v mongodata:/data/db -p 27017:27017 --name mongodb -d mongo
Always check the Docker log to see the chain of events after making changes:
sudo docker logs mongodb
The logs provide a wealth of useful information.

A list of Docker Logs.
Start Interactive Docker Terminal (Bash Shell) to Manage MongoDB Database
The container is currently running in detached mode. Connect to the container using the interactive terminal instead:
sudo docker exec -it mongodb bash


# Start the MongoDB shell by typing mongo in the interactive terminal.


The image confirms we have access to the MongoDB shell.
The MongoDB shell launches and the prompt is ready to accept your commands.

Instead of just typing mongo, you can additionally define a specific host and port by typing:
mongo -host localhost -port 27017  
With the MongoDB shell, you can now create a database, add collections or manage individual documents.

How to Exit MongoDB and Interactive Shell
Type exit to leave the MongoDB shell and then exit once again to leave the Interactive shell.

Steps to exit mongo bash and Docker interactive shell.
As an alternative, you can type quit() or use Ctrl-C to exit the shell.

# Stopping and Restarting MongoDB Database

The docker stop command is a short and clear command that stops running container instances:

sudo docker stop mongodb
Inspect the list of running Docker containers by typing:

sudo docker ps
Containers are started by using the docker start command:

sudo docker start mongodb
The list of running containers now confirms that the MongoDB database has been initiated once again:

sudo docker ps
Terminal images that confirm that MongoDB has stopped and been restarted.




