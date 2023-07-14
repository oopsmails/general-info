# General Linux Knowledges

## apt vs apt-get

I hope I was able to explain the difference between apt and apt-get. In the end, to summarize the apt vs apt-get debate: apt is a subset of apt-get and apt-cache commands providing necessary commands for package management. while apt-get won't be deprecated, as a regular user, you should start using apt more often.

## Linux Service

## what is systemd ?

ChatGPT
Systemd is a system and service manager for Linux operating systems. It is designed to provide a standard process for booting, managing, and maintaining Linux systems. Systemd is responsible for starting and stopping services, managing system resources, handling logging and device management, and other essential tasks.

Here are some key features and components of systemd:

Service Management: Systemd replaces the traditional init system (such as SysV init) and provides improved service management. It can start, stop, restart, and manage the status of system services.

Unit Files: Systemd uses unit files to define system services, devices, mount points, sockets, and other resources. These unit files are written in a specific format and specify the configuration and behavior of the respective units.

Parallel Startup: Systemd allows for parallel startup of services, which helps improve the boot time of the system by executing services concurrently when possible.

Dependency Management: Systemd manages service dependencies, ensuring that services are started or stopped in the correct order based on their dependencies on other services.

Logging and Journaling: Systemd integrates with the systemd Journal, a centralized logging system that collects log messages from various sources and provides efficient storage, filtering, and querying capabilities.

Control Groups (cgroups): Systemd utilizes cgroups, a Linux kernel feature, for resource management. Cgroups enable systemd to allocate and control system resources such as CPU, memory, and I/O for services and processes.

System State Tracking: Systemd tracks and manages the state of the system, including information about running services, device status, and other relevant system data.

Systemd has become the default init system in many Linux distributions, including Ubuntu (since version 15.04), Fedora, CentOS/RHEL 7, and others. It aims to provide a modern, efficient, and standardized approach to system initialization and service management in Linux environments.

### what is the difference between systemd and systemctl?

ChatGPT
Systemd and systemctl are related but serve different purposes:

Systemd: Systemd is a system and service manager that provides a range of functionality for managing and maintaining Linux systems. It is responsible for core system processes, service management, resource management, logging, and more. Systemd is the underlying framework and infrastructure that manages system services and various aspects of the system.

Systemctl: systemctl is a command-line utility that interacts with systemd to control and manage system services. It allows administrators to start, stop, restart, enable, disable, and view the status of services. systemctl provides a convenient interface to interact with systemd and perform service-related operations.

In summary, systemd is the broader system and service management framework, while systemctl is a specific command-line tool used to interact with systemd and manage services. systemctl relies on systemd to carry out its operations.

Here are a few commonly used systemctl commands:

systemctl start service_name: Start a service.
systemctl stop service_name: Stop a service.
systemctl restart service_name: Restart a service.
systemctl enable service_name: Enable a service to start automatically at boot.
systemctl disable service_name: Disable a service from starting automatically at boot.
systemctl status service_name: View the status of a service.
By utilizing systemctl, administrators can conveniently control and manage services, view their status, and configure their behavior within the systemd framework.

### How can I know systemd is enabled or not?

ChatGPT
To determine whether systemd is enabled on your Linux system, you can use the systemctl command to check the default target. Here's how you can do it:

Open a terminal or shell session.

Run the following command:

systemctl get-default

This command will display the default target of your system.

If the output is graphical.target or multi-user.target, systemd is enabled.
If the output is runlevelX.target (where X is a number), your system is using traditional SysV init instead of systemd.

Please note that most modern Linux distributions have adopted systemd as the default init system. However, there might still be some distributions or specific configurations where SysV init or another init system is used instead.

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

- another Springboot example 1

/etc/systemd/system/helloworld.service

[Unit]
Description=Spring Boot HelloWorld
After=syslog.target
After=network.target[Service]
User=username
Type=simple

[Service]
ExecStart=/usr/bin/java -jar /home/linode/hello-world/build/libs/hello-world-0.0.1-SNAPSHOT.jar
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=helloworld

[Install]
WantedBy=multi-user.target

- another Springboot example 2

[Unit]
Description=Spring Boot HelloWorld
After=syslog.target
After=network.target
After=systemd-user-session.service

[Service]
Type=idle
User=username
Group=users
WorkingDir=/opt/abc
ExecStart=/opt/abc/helloworld-boot.sh
TimeoutSec=240
Restart=on-failure
RestartSec=90
StartLimitInterval=350
StartLimitBurst=3
SyslogIdentifier=helloworld
StandardOutput=syslog
StandardError=syslog
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target
```

- linux systemctl vs scripts

Resource restrictions. See man systemd.resource-control for configuration values which could restrict resource consumption. Use systemctl show your-unit-unit.service to check the full configuration values affecting the service you attempting to start.

Non-interactive shell. Your bash CLI environment is an interactive login shell. It has sourced files like .bashrc that systemd has not. Besides setting environment variables, these scripts can do any number of other things, such as connecting an SSH agent so that SSH actions don't require a login. See also Difference between Login Shell and Non-Login Shell?
