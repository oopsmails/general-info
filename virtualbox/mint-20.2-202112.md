# Linux Mint

## General

- hotkey, right ctrl
- hotkey + c, switch displaying between Full mode and Scaled mode.
- Right Control + Home (by default), show vb menu.
- Full mode, can select show vb menu bar.
- multiple workspaces, Ctrl + Alt + Left/Right/Up
## After Install
- root
    - During boot, press and hold Shift (for BIOS) or ESC (for UEFI). In my case, it is Shift.
    - Start with Recovery mode, then root terminal, run *passwd* to change root password

- sudo ./VBoxLinuxAdditions.run

- Resolution cannot keep after logout or restart
  - Make sure VirtualBox Guest Additions is installed
  - Switch around Full screen and make sure Auto-resize guest display is checked.

- Add Shared folder, add as following, make it permenent

C:\sharing
sharing
/home/albert/Documents/sharing

- Add user to group

```
groups

sudo usermod -a -G vboxsf albert
sudo usermod -a -G root albert
```

## Softwares
### Chorme

- Download first
- sudo apt install ./google-chrome-stable_current_amd64.deb
- Now open Chrome, if it asks you for your password, do not enter one choose Continue each time and ignore any warning.
- if still seeing keyring popup,

rm ~/.local/share/keyrings/login.keyring

### VS Code

- Download and install, don't install from Mint Software


### bash profile, Terminal, $HOME/.bashrc

```
# source ~/.bashrc ## for refresh without recycle terminal

PATH="$HOME/Documents:$PATH"
PATH="$HOME/Documents/programs:$PATH"
PATH="$HOME/Documents/sharing:$PATH"

```
### OpenJDK:

```
sudo apt update

sudo apt install openjdk-8-jdk

sudo apt install openjdk-11-jdk

sudo update-java-alternatives --list

sudo update-alternatives --config java # This can switch around versions

```

sudo apt remove openjdk-14-jdk

- add to bash profile

```
# Java Alias
alias java8='source /home/albert/Documents/programs/java8.sh'
alias java11='source /home/albert/Documents/programs/java11.sh'
alias java17='source /home/albert/Documents/programs/java17.sh'

```

- Notes
  - scripts need with LF, not CRLF
  - update-java-alternatives might not work anymore, use update-alternatives
  - use *-set instead* of *-config java* in scripts to avoid using *echo*
  - java version names need to be complaint to *update-java-alternatives --list*
  - java 8 is actually pointing to jre?? use is anyways.


### intellij: download and install

```
cd Downloads
tar xvf 
sudo mv idea-IC-201.8538.32 /opt/idea
/opt/idea/bin/idea.sh
```

### Git

- install from Linux Mint Software

### Meld: for like WinMerge or BeyondCompare

- install from Linux Mint Software

### Docker and docker-compose

- install from Linux Mint Software
- usermod -aG docker ${USER}

### nvm, node, npm

- `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash`

- close terminal and reopen

nvm --version

- install latest node

nvm install node
node -v

- install LTS

nvm install --lts

### python, handling *npm i* error, python not found

- check if should use *sudo*!!!
Using *sudo* will solve some errors, like,

Error: listen EACCES: permission denided ...


```
sudo npm i
```

- if *nvm* not available to *sudo*, error, not found

Ref: https://stackoverflow.com/questions/21215059/cant-use-nvm-from-root-or-sudo

  - first solution, should be used

```
My solution is to create symbolic links from the versions of node and npm I'm using to /usr/local/bin:

sudo ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/node" "/usr/local/bin/node"
sudo ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/npm" "/usr/local/bin/npm"
This makes npm and node available to all users.
```

  - second solution

```
The fundamental reason is because nvm is not a real program. It's a bash function that gets loaded in the user's .profile, .bashrc, or ... So sudo doesn't automatically pick it up from the $PATH like most other programs.

An alternative node version manager is n: https://github.com/tj/n . That is a real program, so sudo will pick it up via the $PATH without any hacks (as long as sudo has /usr/local/bin in its $PATH).
```

- check if python is installed first!!!

```
apt list --installed | grep python

albert@albert-mint20:~$ python3 -V
Python 3.8.5


albert@albert-mint20:~$ which python
albert@albert-mint20:~$ 
albert@albert-mint20:~$ which python3
/usr/bin/python3
albert@albert-mint20:~$ which python3.8
/usr/bin/python3.8

```

- Make sure you installed python on your machine.

If already installed try:

```
npm config set python <python.exe path>

npm config set python /c/programs/python310/python.exe

npm config set python /usr/bin/python3
```


- install 3.9.6

Ref: https://www.youtube.com/watch?v=dN2o_xKXw8M

```
Python3.9.6 Installation Steps:
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.9
```

- install 3.8, instruction from python-install-ElementaryOS.md

```
1. Open a terminal
2. type and run: sudo apt update
3. type and run: sudo apt install software-properties-common
4. type and run: sudo add-apt-repository ppa:deadsnakes/ppa
5. Press Enter to add the above repository
6. type and run: sudo apt update
7. type and run: sudo apt install python3.7

You now have Python 3.7 installed

sudo apt install python3.8
```


## Other

```
albert@eosvm:~/Documents/github/general-info$ docker images
REPOSITORY                                                    TAG                 IMAGE ID            CREATED             SIZE
spring-boot-kafka-ms-email-files_spring-boot-kafka-ms-email   latest              96c27d43734f        6 minutes ago       440MB
redis                                                         alpine              554d20f20365        6 weeks ago         32.3MB
wiremock-docker_wiremock                                      latest              644ebd2fcff6        7 weeks ago         286MB
adminer                                                       latest              396a2cb178d1        2 months ago        89.8MB
bitnami/kafka                                                 2                   cafbcefb7749        3 months ago        578MB
bitnami/zookeeper                                             3                   10f421be0c91        3 months ago        467MB
nginx                                                         alpine              eb9291454164        3 months ago        22.6MB
maven                                                         3.6.3-jdk-11-slim   afe490bdb813        3 months ago        439MB
sonarqube                                                     latest              b1002786c603        7 months ago        657MB
rodolpheche/wiremock                                          latest              0e2fcbe166e7        8 months ago        286MB
wurstmeister/kafka                                            latest              40094a582680        9 months ago        435MB
mailhog/mailhog                                               latest              4de68494cd0d        9 months ago        392MB
mysql/mysql-server                                            latest              8a3a24ad33be        10 months ago       366MB
obsidiandynamics/kafdrop                                      latest              5b5ea1807970        11 months ago       608MB
mongo                                                         4.2.2               105a8b77784b        16 months ago       364MB
mysql                                                         8.0.17              b8fd9553f1f0        21 months ago       445MB
wurstmeister/zookeeper                                        latest              3f43f72cb283        2 years ago         510MB
```




- with spring-boot-kafka-ms-email
docker pull bitnami/kafka:2
docker pull bitnami/zookeeper:3
docker pull mailhog/mailhog:lastest
docker pull obsidiandynamics/kafdrop:lastest
docker pull nginx:alpine
docker pull maven:3.6.3-jdk-11-slim

- dev test
docker pull redis:alpine
docker pull wurstmeister/kafka:lastest
docker pull wurstmeister/zookeeper::lastest

- dev db
docker pull mysql:8.0.17
docker pull mongo:4.2.2
docker run -it -v /dockerdata/mongodb:/data/db -p 27017:27017 --name mongodb -d mongo:4.2.2
docker pull adminer:lastest

- dev env usage
docker pull rodolpheche/wiremock:lastest
docker pull sonarqube:lastest

- TBD
wiremock-docker_wiremock:lastest





Digest: sha256:882aac582eac93663773f314feeaa84cda7cf65053fde95e2747d488ddc09ca5
Status: Downloaded newer image for bitnami/kafka:2
Building spring-boot-kafka-ms-email
Step 1/6 : FROM maven:3.6.3-jdk-11-slim
3.6.3-jdk-11-slim: Pulling from library/maven
75646c2fb410: Pull complete
875a154571f0: Pull complete
b1f3c7e21fd9: Pull complete
1ad99caee48d: Pull complete
bcf1c87a8025: Pull complete
69e76680a7d9: Pull complete
8e035f3b1535: Pull complete
466c509e4a91: Pull complete
Digest: sha256:f20d0ce5e56b53258735976084786d4133946c1755b53f8c5572b34b51a3cc3c
Status: Downloaded newer image for maven:3.6.3-jdk-11-slim
 ---> 0627c0e38d77
Step 2/6 : RUN useradd -d /home/deploy -m -s /bin/bash deploy
 ---> Running in d0d4149e4a92
Removing intermediate container d0d4149e4a92
 ---> 2b2012c80658
Step 3/6 : WORKDIR /tmp/app
 ---> Running in 131772c054a2
Removing intermediate container 131772c054a2
 ---> 7c43bde3e833
Step 4/6 : RUN chown -R deploy:deploy .
 ---> Running in 85e2402f128f
Removing intermediate container 85e2402f128f
 ---> 80bb0d8cd2c6
Step 5/6 : USER deploy
 ---> Running in 7a6e4ac09f57
Removing intermediate container 7a6e4ac09f57
 ---> fe79fa0aaa45
Step 6/6 : EXPOSE 8080
 ---> Running in 802d76dee1b7
Removing intermediate container 802d76dee1b7
 ---> bd3655baec29
Successfully built bd3655baec29
Successfully tagged spring-boot-kafka-ms-email-files_spring-boot-kafka-ms-email:latest
WARNING: Image for service spring-boot-kafka-ms-email was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Pulling kafdrop (obsidiandynamics/kafdrop:)...





