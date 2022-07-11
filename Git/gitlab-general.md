
# GitLab onboarding

oopsmails@g
S5s

## Generate an SSH key pair

https://docs.gitlab.com/ee/ssh/index.html#generate-an-ssh-key-pair


For example, for ED25519:

ssh-keygen -t ed25519 -C "<comment>"

ssh-keygen -t ed25519 -C "gitlab oopsmails 20211010"
changeit

```
$ ssh-keygen -t ed25519 -C "gitlab oopsmails 20211010"
Generating public/private ed25519 key pair.
Enter file in which to save the key (/c/Users/<username>/.ssh/id_ed25519):
Created directory '/c/Users/<username>/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /c/Users/<username>/.ssh/id_ed25519
Your public key has been saved in /c/Users/<username>/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:/UirNATOyOl8799HkA1z5OImxq8s6Uds4DobD6eR+JY gitlab oopsmails 20211010
The key's randomart image is:
+--[ED25519 256]--+
|             ..  |
|            o..  |
|      .     .*.  |
|   . = ..o .o..  |
|    + o.So* o.   |
|   o . o.o+B  .  |
|    + *o++o o.   |
|     oEXo+.o  .  |
|     .+=*++ ..   |
+----[SHA256]-----+


```

For 2048-bit RSA:

ssh-keygen -t rsa -b 2048 -C "<comment>"

```
$ git clone git@gitlab.com:albertmails/springbootdev.git
Cloning into 'springbootdev'...
The authenticity of host 'gitlab.com (2606:4700:90:0:f22e:fbec:5bed:a9b9)' can't be established.
ECDSA key fingerprint is SHA256:HbW3g8zUjNSksFbqTiUWPWg2Bq1x8xdGUrliXFzSnUw.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'gitlab.com,2606:4700:90:0:f22e:fbec:5bed:a9b9' (ECDSA) to the list of known hosts.
Enter passphrase for key '/c/Users/liu/.ssh/id_ed25519':
warning: You appear to have cloned an empty repository.

- Using

$ git clone https://gitlab.com/albertmails/springbootdev.git
```

## init and new repo

echo "# gradle-tutorial" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/oopsmails/gradle-tutorial.git
git push -u origin main


