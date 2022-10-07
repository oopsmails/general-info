# Accessing Ubuntu using Chrome Remote Desktop

## Ubuntu


### How to Install and Setup Chrome Remote Desktop for Ubuntu 20.04

- Install the Google Chrome Browser on your system.

- Log in to Google using your Gmail account. It’s a prerequisite for using Chrome Remote Desktop.

- Go to the Chrome web store and locate the Chrome Remote Desktop extension.

- Install Chrome Remote Desktop for Linux

- Click Add to Chrome to install the extension in your browser. You should see the remote desktop icon next to the search address bar.

- Install the Chrome remote desktop package which furnishes the necessary host components with the following two commands:
```

    • wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb -P /tmp
    • apt install /tmp/chrome-remote-desktop_current_amd64.deb

```

- Enable remote desktop connections by opening the Chrome remote desktop extension and clicking Turn on. **If the button is not visible, create the Chrome remote desktop configuration directory:**

*mkdir ~/.config/chrome-remote-desktop* . Then reopen the remote desktop extension.

- Enter a name for the computer and click Next.

- Set the remote connection PIN. It should be at least 6 digits.
After setting the PIN, click Start to run Chrome Remote Desktop.


## How to Install and Setup Chrome Remote Desktop on Linux Mint 20

Google has developed a Chrome Remote Desktop installation package that is only compatible with Debian-based Linux distros like Ubuntu and Mint. Use the following procedure to install Chrome Remote Desktop in a Linux Mint 20 system.


- Download either the 32-bit or 64-bit Debian package depending on your system requirements.


- Open a Terminal Window and change to your download directory.


- Type the following command in the Terminal Window:

```
sudo dpkg -i chrome-remote-desktop_current_amd64.deb
or sudo dpkg -i chrome-remote-desktop_current_i386.deb for 32 bit machines.
```

- Enter *sudo /etc/init.d/chrome-remote-desktop stop* to ensure the service is not running yet.


- Create a virtual desktop session by creating a file named
*.chrome-remote-desktop-session* in your home directory.


- Enter this command in the file: *startxfce4* .


- Open your .profile file and enter the following command on a new line at the end of the file:
  
```
export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1024×768 .
```
Save the file.


- Enter the following command in your Terminal Window:

```
sudo /etc/init.d/chrome-remote-desktop start 
```

Now all you need to do is enable remote connections with the following steps.

Open the Chrome Remote Desktop app.

Click Enable remote connections.

Enter a PIN, confirm it by repeating the numbers, and click OK.

Dismiss the confirmation dialog.

Close all running programs and reboot the box.


## Trouble Shooting

- If only seeing black screen

Need to logout Ubuntu and re-connect with default session

## Ref:

https://www.helpwire.app/blog/chrome-remote-desktop-linux/


