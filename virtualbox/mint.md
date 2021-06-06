
# MintOS

## General

- hotkey, right ctrl
- hotkey + c, switch displaying between Full mode and Scaled mode.
- Right Control + Home (by default), show vb menu.
- Full mode, can select show vb menu bar.

- root
    - During boot, press and hold Shift (for BIOS) or ESC (for UEFI). In my case, it is Shift.
    - Start with Recovery mode, then root terminal, run *passwd* to change root password


## Before Backup

### Resolution cannot keep after logout or restart

- Make sure VirtualBox Guest Additions is installed
- Switch around Full screen and make sure Auto-resize guest display is checked.

### Display only 800*600, need to 1640*864

### install Extension Guest

- insert Guest, settings, Storage, select the Guest iso. Guest iso is there after installing Extension on Host.

- run inside linux mint

sudo ./VBoxLinuxAdditions.run

### Add Shared folder

- add as following, make it permenent

C:\sharing

sharing

/home/albert/Documents/sharing

### Add user to group

```
groups

sudo usermod -a -G vboxsf albert
sudo usermod -a -G root albert
```

### Install Chrome, import Favorites and make a BK

## Install Softwares

### Chorme

- download first
- sudo apt install ./google-chrome-stable_current_amd64.deb
- keyring,

rm ~/.local/share/keyrings/login.keyring

Now open Chrome, if it asks you for your password, do not enter one choose Continue each time and ignore any warning.

### Enable snapd and install vscode

- Ref:
https://snapcraft.io/install/code/mint

- Commands

```
sudo rm /etc/apt/preferences.d/nosnap.pref
sudo apt update

sudo apt install snapd
sudo snap install code --classic

-- to remove
sudo snap remove code
```

- vs code

    - run, in Terminal, just type code
    - in panel, right click, "Create shortcut"
    - click Menu, search code, then add to panel, but the icon might not be correct
    - fix icon, open /home/albert/.local/share/applications/Code --No-Sandbox.cinnamon-generated.desktop
    - add "Icon=/snap/code/65/snap/gui/com.visualstudio.code.png" after "Exec=/snap/code/65/usr/share/code/code --no-sandbox"



### Terminal, .profile file is NOT used in Elementary OS, should be $HOME/.bashrc


PATH="$HOME/Documents:$PATH"
PATH="$HOME/Documents/sharing:$PATH"
PATH="$HOME/Documents/programs:$PATH"

export JAVA_HOME_8=$(/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -v1.8)
export JAVA_HOME_11=$(/usr/lib/jvm/java-11-openjdk-amd64/bin/java -v11)
export JAVA_HOME_14=$(/usr/lib/jvm/java-14-openjdk-amd64/bin/java -v14)

alias java8='export JAVA_HOME=$JAVA_HOME_8'
alias java11='export JAVA_HOME=$JAVA_HOME_11'
alias java14='export JAVA_HOME=$JAVA_HOME_14'


### Git

- Installed from Software Manager

- NOT used following
git
```
sudo apt update
sudo apt install git
```

### intellij: see mint-issues.md for more

- Option 1: finally used.

```
cd Downloads
tar xvf 
sudo mv idea-IC-201.8538.32 /opt/idea
/opt/idea/bin/idea.sh
```

- Option 2
```
sudo snap install intellij-idea-community --classic
or

sudo snap install intellij-idea-community --classic --edge

```

- Option 3: install from Software Manager

**DONOT use Software Manager to install intellij**, it is a flatpack version. Cannot find jdk and even use /var/run/host/usr/lib/jvm/java-11-openjdk, may end up with network issues.

### java

- Software Manager, search jdk, install Default-jdk

- Did not use below

```
sudo apt update
sudo apt install default-jdk
- ... update-alternatives: using /usr/lib/jvm/java-11-openjdk-amd64/bin/jar to provide /usr/bin/jar (jar) in auto mode
```

### Meld: for like WinMerge or BeyondCompare

- installed from Software Manager

### Docker:

- Ref: 

https://linuxhint.com/install_docker_linux_mint/

- Cannot install from Software Manager, search Docker, the download is with error

- Linux mint 20 is based on Ubuntu Focal

- Installation

    - At first, it’s STRONGLY recommended to make sure that there’s no version of Docker installed previously.

    sudo apt remove docker docker-engine docker.io containerd runc

    - Make sure that APT cache is up-to-date.

    sudo apt update

    - By default, APT doesn’t use HTTPS. Install the following packages that will allow APT to use a repository over HTTPS.

    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

    - For enabling the Docker repo, the official Docker key is important. Time to add the official GPG key of Docker into the APT keyring.

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    - Even after the successful addition of the key, it’s safe to verify the key. Run the following command –

    sudo apt-key fingerprint 0EBFCD88

    - In the case of Docker, there are 3 different repositories – “stable” (recommended for everyone), “nightly” or “test”. Let’s configure the “stable” repo.

    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" <------------------------ 20210521, this is used, 

    - Once the repositories have been added, it’s necessary to refresh the APT cache again.

    sudo apt update

    - Finally, install the latest version of Docker CE and containerd.

    sudo apt install docker-ce docker-ce-cli containerd.io

    - install docker-compose

    sudo apt install docker-compose


- Or, may download all and install

    - Go to

    https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/


    - download the latest versions of containerd and docker-ce-cli or docker-ce.

    cd ~/Downloads/
    sudo apt install ./*.deb


### nvm, node, npm

- `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash`

- close terminal and reopen

nvm --version

- install latest node

nvm install node
node -v

- install LTS

nvm install --lts





