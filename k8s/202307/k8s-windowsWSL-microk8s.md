# MicroK8s on Windows WSL

## Install MicroK8s

### installed WSL Ubuntu

### installed Docker

### check systemd is enabled

```
albert@lenovo-small:~$ systemctl get-default
graphical.target

```

This command will display the default target of your system.

If the output is graphical.target or multi-user.target, systemd is enabled.
If the output is runlevelX.target (where X is a number), your system is using traditional SysV init instead of systemd.

### check snap is enabled

```
albert@lenovo-small:~$ snap list

Name                      Version          Rev    Tracking         Publisher   Notes
bare                      1.0              5      latest/stable    canonical✓  base
core22                    20230612         766    latest/stable    canonical✓  base
gtk-common-themes         0.1-81-g442e511  1535   latest/stable/…  canonical✓  -
snapd                     2.59.5           19457  latest/stable    canonical✓  snapd
ubuntu-desktop-installer  0+git.bc612347   1118   latest/edge      canonical✓  classic


albert@lenovo-small:~$
albert@lenovo-small:~$ snap info microk8s
```

7:58 of 20:07

### install MicroK8s

```
# Install the "latest/stable" version
sudo snap install microk8s --classic

# Check the status from Microk8s > this might take 1 or 2 minutes
sudo microk8s.status

- Here, fixing permission issue

# Add the user to the microk8s group
sudo usermod -a -G microk8s mk8s
# Set the ownership of the .kube directory back to the user
sudo chown -f -R mk8s ~/.kube
# Exit this session and enter again
exit
wsl
# Run the status command again
microk8s.status



# Check the Kubernetes version installed (client & server)
sudo microk8s.kubectl version

# Check that the cluster is running correctly
sudo microk8s.kubectl cluster-info

```

### install microk8s dns and dashboard

```
# Let's enable the DNS and Dashboard addons
microk8s.enable dns dashboard

```

### to use dashboard

12:23 of 20:07: display the token

```
# Get the access token to be able to login into the Dashboard
token=$(microk8s.kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)

microk8s.kubectl -n kube-system describe secret $token

# Select the token value and right click to copy
# Currently the Dashboard is only accessible via the ClusterIP, so let's forward a port to access it externally

microk8s.kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443 &


- 14:26 of 20:07: display the token

microk8s kubectl -n kube-system port-forward --address 0.0.0.0 service/kubernetes-dashboard 5000:433

# Open https://localhost:10443 in the browser

$BROWSER https://localhost:10443

# Click Advanced > Click Proceed to Localhost > Choose Token and past your token

```

## Refs:

https://www.youtube.com/watch?v=DmfuJzX6vJQ

https://wsl.dev/wsl2-microk8s/
