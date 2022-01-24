
# Install Ubuntu on USB Stike

- Ref:

https://www.youtube.com/watch?v=cHF1ByFKtZo

Install Ubuntu 20.04 On LIVE USB / SSD With Persistent Storage (Plug & Play)


## Steps

### Download Ubuntu LTS Desktop ISO

Ubuntu - https://ubuntu.com/

### Download Rufus

Rufus - https://rufus.ie/

- What if rufus is not showing my External ssd???

Solution: If RUFUS doesn't show your external ssd try ALT+F, below you will see  a message like "Hard disk detection" is ON/OFF.............It has stolen me a big amount of minutes

### Run after installation

```
sudo apt update && sudo apt upgrade -y 

sudo add-apt-repository universe 

sudo add-apt-repository multiverse
```

