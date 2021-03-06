
# General Knowledge

## Configure Proxy

- Open a "Terminal" to edit the file /etc/cntlm.conf

`sudo nano /etc/cntlm.conf`

- Update the lines to match your credentials:

```
Username yourUsername
Domain yourDomain
```

- Run command in shell:

`sudo cntlm -H`

- Copy results in back into cntlm.conf

```
PassLM 1afeffsdfssaaaaaaaaaafaaaaaaaaaa
PassNT 1afeffsdfssasefqwefavafvaswfaaaa
PassNTLMv2 sdgadasddgasdasdggagadgsdadsfsgagad
```

- Restart cntlm

`sudo /etc/init.d/cntlm restart`


## Configure Git

- Git is pre-installed in the virtual machine, change the global configurations in Git to match your identity:

$ git config --global user.name "<your name>"
$ git config --global user.email "<your email>"
$ git config --global --list


- Setup SSH with Bitbucket, so not to enter username password anymore

Open a "Terminal" to generate a key:

`ssh-keygen -t rsa`

Copy the content of the public key into your Bitbucket account:

`cat ~/.ssh/id_rsa.pub`


To add the content to your Bitbucket account:

Go https://bitbucket.repo

Click on "Add key"

Paste the content in the text box and click "Add key"



