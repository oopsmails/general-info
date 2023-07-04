# Install Docker Desktop on Windows

## How can I run mysql db docker image on windows 11 by using WSL?

ChatGPT
To run a MySQL database Docker image on Windows 11 using Windows Subsystem for Linux (WSL), you can follow these steps:

### Enable Windows Subsystem for Linux:

Open PowerShell as an administrator.
Run the following command:
powershell

wsl --install

Restart your computer when prompted.

### Install a Linux distribution:

Open the Microsoft Store.
Search for a Linux distribution of your choice (e.g., Ubuntu, Debian).
Click on the distribution you want to install and click "Install."

### Launch the Linux distribution:

Open the Start menu and search for the installed Linux distribution.
Launch it, and the initial setup will take place.
Provide a username and password when prompted.

### Update the Linux distribution:

Run the following commands to update the Linux distribution's packages:
bash

sudo apt update
sudo apt upgrade

### Install Docker:

Run the following commands to install Docker on the Linux distribution:

bash

```
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
```

Pull the MySQL Docker image:

Run the following command to pull the MySQL Docker image:
bash

```
sudo docker pull mysql
```

Run the MySQL container:

Use the following command to start a MySQL container:

```
sudo docker run -d --name mysql-container -e MYSQL_ROOT_PASSWORD=your_password -p 3306:3306 mysql
```

Replace your_password with a strong password of your choice.

This command runs the MySQL container in detached mode (-d), names it mysql-container (--name), sets the root password using the MYSQL_ROOT_PASSWORD environment variable, and maps port 3306 from the container to the host using -p 3306:3306.

Verify the container is running:

Run the following command to see the running containers:

```
sudo docker ps
```

You should see the mysql-container listed with its status.

Connect to MySQL:

To connect to the MySQL database from within the Linux distribution, you can use the following command:

```
sudo docker exec -it mysql-container mysql -uroot -p
```

Enter the root password you set earlier when prompted.

You should now be connected to the MySQL database and can execute SQL commands.

That's it! You have successfully run a MySQL database Docker image on Windows 11 using WSL. You can now interact with the database using command-line tools or connect to it from applications running on your Windows system.

## thanks, how can I define a volume to make sure my data is saved?

ChatGPT

To define a volume for your MySQL Docker container to ensure that your data is saved and persists even if the container is restarted or removed, you can use the following steps:

### Create a directory on your host machine where you want to store the MySQL data. For example, you can create a directory named mysql_data in your home directory.

### Modify the docker run command to include a volume mapping:

```
sudo docker run -d --name mysql-container -e MYSQL_ROOT_PASSWORD=your_password -p 3306:3306 -v /path/to/mysql_data:/var/lib/mysql mysql

```

Replace /path/to/mysql_data with the absolute path to the directory you created in step 1.

This command adds the -v option to map a volume between the host and the container. It maps the /path/to/mysql_data directory on the host to the /var/lib/mysql directory inside the container, which is where MySQL stores its data.

### Start the container with the modified docker run command.

By using the volume mapping, the MySQL data will be stored in the mysql_data directory on your host machine. This ensures that the data will be persisted even if the container is restarted, removed, or replaced.

Note: Make sure to back up your MySQL data regularly to prevent data loss and ensure data integrity.

## Connect to DB

### I got error "public key retrieval is not allowed" ...

The "public key retrieval is not allowed" error typically occurs when the MySQL client is unable to retrieve the public key of the MySQL server for authentication purposes. This error can happen when connecting to a MySQL server running in a Docker container due to certain configuration settings.

To resolve this issue, you can try the following steps:

Add allowPublicKeyRetrieval=true to your connection URL:

In DBeaver, when creating or editing the MySQL connection, find the "Connection URL" field.
Append ?allowPublicKeyRetrieval=true to the connection URL, for example:

```
jdbc:mysql://localhost:3306/?allowPublicKeyRetrieval=true
```

Save the changes and try connecting again.

Specify the --allow-public-key-retrieval option in the docker run command:

Stop and remove the existing MySQL container (if running) using the following commands:

```
sudo docker stop mysql-container
sudo docker rm mysql-container
```

Modify the docker run command to include the --allow-public-key-retrieval option:

```
sudo docker run -d --name mysql-container -e MYSQL_ROOT_PASSWORD=your_password -p 3306:3306 --allow-public-key-retrieval mysql
```

Start the container with the modified docker run command.

Upgrade the MySQL client library in DBeaver:

Download the latest version of the MySQL Connector/J library from the official MySQL website: https://dev.mysql.com/downloads/connector/j/
Extract the downloaded archive and locate the mysql-connector-java-x.x.xx.jar file.
In DBeaver, go to the "Driver Manager" section and find the MySQL driver entry.
Click on the "Edit" button for the MySQL driver and navigate to the "Driver Files" tab.
Click on the "Add File" button and select the mysql-connector-java-x.x.xx.jar file you downloaded.
Save the changes and try connecting again.
These steps should help resolve the "public key retrieval is not allowed" error when connecting to a MySQL server running in a Docker container. If the issue persists, ensure that your MySQL server configuration allows public key retrieval and that the Docker container is properly set up.

## About MSSQL volume

### No, what I meant was that we didn't define volume, but the data is still there after stop and restart ...

I apologize for the confusion in my previous responses. You are correct that in certain cases, when you stop and restart a container without explicitly defining a volume, the data can still persist within the container.

In the case of the MSSQL Docker image, the data is stored in the /var/opt/mssql directory inside the container. This directory is typically designated as a volume within the image itself. As a result, when you stop and restart the container, the data remains intact because it is stored within the designated volume.

While this behavior may vary depending on the specific Docker image and its configuration, many official Docker images, including the MSSQL image, are designed to persist data within designated volumes by default. This allows the data to be retained even when the container is stopped or restarted, providing a more convenient development and testing experience.

However, it's important to note that relying on data persistence without explicitly defining a volume is not recommended in production scenarios or situations where data integrity and backup are critical. In those cases, it's advisable to define explicit volumes or explore other data storage and backup strategies to ensure the safety and availability of your data.
