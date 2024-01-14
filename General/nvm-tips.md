# NVM

## Download NVM Zip version

- Unzip in C:/programs/nvm

## Config: Windows

- Set environment variable
  NVM_HOME=C:/programs/nvm
  Note: no need to add NVM_SYMLINK=C:\Programs\nodejs
- Update PATH=%NVM_HOME%;....
  in env variables, PATH
  add
  %NVM_HOME%
  Note: no need to add %NVM_SYMLINK%

- Run in cmd or powershell

```
nvm root %NVM_HOME%

this will write "root: C:\Programs\nvm" in seetings.txt in nvm folder

if settings.txt not exist, just create an empty one.

nvm install v16.17.0
nvm install v12.16.2

```

```
- This if an example, after switching to a new machine.
Need to delete original, C:\Programs\nodejs, because it should be a linked folder. It will be created during "nvm use ..."

C:\Windows\System32>nvm list

    18.12.1
    16.13.0

C:\Windows\System32>nvm use 16.13.0
Now using node v16.13.0 (64-bit)

C:\Windows\System32>node -v
'node' is not recognized as an internal or external command,
operable program or batch file.

C:\Windows\System32>nvm root %NVM_HOME%

Root has been set to C:\Programs\nvm

C:\Windows\System32>nvm install 16.13.0
Version 16.13.0 is already installed.

C:\Windows\System32>nvm uninstall 16.13.0
Uninstalling node v16.13.0... done
C:\Windows\System32>nvm uninstall 18.12.1
Uninstalling node v18.12.1... done
C:\Windows\System32>nvm install 16.13.0
Downloading node.js version 16.13.0 (64-bit)...
Complete
Creating C:\Programs\nvm\temp

Downloading npm version 8.1.0... Complete
Installing npm v8.1.0...

Installation complete. If you want to use this version, type

nvm use 16.13.0

C:\Windows\System32>nvm install 18.12.1
Downloading node.js version 18.12.1 (64-bit)...
Complete
Creating C:\Programs\nvm\temp

Downloading npm version 8.19.2... Complete
Installing npm v8.19.2...

Installation complete. If you want to use this version, type

nvm use 18.12.1

C:\Windows\System32>nvm use 16.13.0
Now using node v16.13.0 (64-bit)
```

- 20240114: How to make cmd and gitbash working

after nvm use ..., make sure there is a linked folder showing in C:/Programs, called nodejs

why, because in settings.txt in nvm is as "root: C:\Programs\nvm"

Now, add,

- Set environment variable
  add NVM_SYMLINK=C:\Programs\nodejs
- Update PATH=%NVM_HOME%;....
  in env variables, PATH
  add %NVM_SYMLINK%

Then, cmd or gitbash are all working and sync-ed.

- NOT needed, Wheneven to use a specific node version, run following in cmd or powershell, for example

```
set PATH=%NVM_HOME%/v16.17.0;%PATH%
```

- NO ... Note: Gitbash could still using whatever installed initially ...

## VS Code: configure Terminal

- F1 or ctrl + shift + P

"Terminal: Select Default Profile" or "Terminal: Select Default Shell" in older version.

- Or, actually, click "+" sign on opened terminal (after ctrl + `) and select Command Prompt or PowerShell. This way is fine with individual workspaces.
