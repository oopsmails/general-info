# Github

## Errors

### github remote: Support for password authentication was removed on August 13, 2021.

https://stackoverflow.com/questions/68775869/message-support-for-password-authentication-was-removed-please-use-a-personal

For a Linux-based OS ⤴
For Linux, you need to configure the local GIT client with a username and email address,

$ git config --global user.name "your_github_username"
$ git config --global user.email "your_github_email"
$ git config -l


git config --global credential.helper cache

git pull or git push

