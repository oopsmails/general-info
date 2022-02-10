# Install MacOS Catalina on Virtual Box

## Download vmdk and install

### if virtualbox macos startup.nsh

https://www.youtube.com/watch?v=A3z64QUTJsM

Virtualbox UEFI Shell startup.nsh Error Fixed (MacOS, Linux, Windows any OS)

Storage, add "big sur 11.1 VMDK by Techrechard.vmdk"


Basically, go through FS0:, FS1: ... to look for boot.efi

/System/Library/CoreServices/boot.efi

then, just run it.

## Tips

- Keyboard, ~, On my U.S. layout keyboard it works to use shift+\ (button next to left shift, see the screenshot)
- Keyboard, `, just \, the button next to left shift.

- Here's how can automount a network drive

Connect to your network drive (finder > go > connect to server)
Enter the credentials for your login to your network drive and tick the ‘remember in keychain’
Open system settings > users > login items
Drag the icon for your network drive from your desktop to the startup items.


## Software


### HomeBrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


### nvm


#### If you already have node installed, uninstall it. 

I had Node installed via Homebrew and found that I needed to first uninstall node.
brew uninstall --ignore-dependencies node
brew uninstall --force node

#### brew install nvm

brew update
brew install nvm

#### Next, create a directory for NVM.
mkdir ~/.nvm

#### Now add these lines to ~/.bash_profile ( or ~/.zshrc for macOS Catalina or later)

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh


#### Now either quit and reopen your Terminal, or run
source ~/.bash_profile


#### Validate

Echoing $NVM_DIR should now return your NVM directory

jamesauble@James-MacBook-Air:$ echo $NVM_DIR
/Users/jamesauble/.nvm

Now running nvm -v should return nvm’s options.

To see what Node versions are available to install run:

nvm ls-remote

#### install Nodejs

nvm install 16.13.0


### Shell, use zsh

touch ~/.zshrc

- shell in vs code

Go to Settings, search *terminal.integrated.defaultProfile*, set Osx shell as zsh from drop down

```
macos vscode terminal lag:

Unfortunately, below not working

You can fix this by removing the code signing 

codesign --remove-signature /Applications/Visual\ Studio\ Code.app/Contents/Frameworks/Code\ Helper\ \(Renderer\).app

```















