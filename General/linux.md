
## General Linux Knowledges

## Linux Service

### systemctl

/etc/systemd/system/app-boot.service

```
albert@albert-mint20:/etc/systemd/system$ cat display-manager.service
[Unit]
Description=Light Display Manager
Documentation=man:lightdm(1)
Conflicts=getty@tty7.service plymouth-quit.service
After=systemd-user-sessions.service getty@tty7.service plymouth-quit.service

[Service]
# temporary safety check until all DMs are converted to correct
# display-manager.service symlink handling
ExecStartPre=/bin/sh -c '[ "$(basename $(cat /etc/X11/default-display-manager 2>/dev/null))" = "lightdm" ]'
ExecStart=/usr/sbin/lightdm
Restart=always
BusName=org.freedesktop.DisplayManager
```

- linux systemctl vs scripts

Resource restrictions. See man systemd.resource-control for configuration values which could restrict resource consumption. Use systemctl show your-unit-unit.service to check the full configuration values affecting the service you attempting to start.

Non-interactive shell. Your bash CLI environment is an interactive login shell. It has sourced files like .bashrc that systemd has not. Besides setting environment variables, these scripts can do any number of other things, such as connecting an SSH agent so that SSH actions don't require a login. See also Difference between Login Shell and Non-Login Shell?

