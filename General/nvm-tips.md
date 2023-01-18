# NVM

## Download NVM Zip version

- Unzip in C:/programs/nvm
  
## Config: Windows

- Set environment variable NVM_HOME=C:/programs/nvm
- Update PATH=%NVM_HOME%;....
- Run in cmd or powershell

```
nvm root %NVM_HOME%

if settings.txt not exist, just create an empty one

nvm install v16.17.0
nvm install v12.16.2

```

- Wheneven to use a specific node version, run following in cmd or powershell, for example

```
set PATH=%NVM_HOME%/v16.17.0;%PATH%
```

> Note: Gitbash could still using whatever installed initially ...

## VS Code: configure Terminal

- F1 or ctrl + shift + P

"Terminal: Select Default Profile" or "Terminal: Select Default Shell" in older version.

- Or, actually, click "+" sign on opened terminal (after ctrl + `) and select Command Prompt or PowerShell. This way is fine with individual workspaces.




