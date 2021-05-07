
# Windows 10 remember git credentials

- Ref:

https://snede.net/git-does-not-remember-username-password/#:~:text=Go%20to%20Windows%20Credentials%20%2D%3E%20Generic,in%20to%20a%20new%20repository.

## Set git global manager

- You can check this by running the following command in CMD or Powershell:

git config --list

It will then list all settings for git. You are looking for the credential.helper which should be equal to manager, eg. credential.helper=manager.

- Set credential helper
If it is not set, or you want to make sure it is. Run the following command to set the config on a global level.

git config --global credential.helper manager

And if you want a complete sanity check, you can unset it first via:

git config --global --unset credential.helper

- Do a git pull

This will add Credentials in Windows Credentials Manager automatically !!!!

- DO NOT have to manually 

Note that the internet or network address includes a *git:* statement, this is important!

If you have an incorrect listing, remove it before continuing.




