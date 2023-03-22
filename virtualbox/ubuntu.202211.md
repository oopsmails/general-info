## On Startup asking password for "color profile"

- search "ubuntu color profile authentication"

Ref: https://devanswers.co/how-to-fix-authentication-is-required-to-create-a-color-profile-managed-device-on-ubuntu-20-04-20-10/

```

sudo nano /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla


[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes

```

## How to disable screensaver lock?

- Ref:

https://askubuntu.com/questions/1117025/how-to-disable-screensaver-lock

Privacy ::> Screen Lock

## ubuntu shutdown without password

???

grep -rnw '/path/to/somewhere/' -e 'pattern'
grep -rnw . -e 'restart-multiple-users'

## ubuntu set font size

- You can configure the font size in Ubuntu using the following steps:

Open the "Settings" application by clicking on the gear icon in the top-right corner of the screen.

Click on "Universal Access" in the left-hand sidebar.

Scroll down to the "Text and Display" section and click on "Large Text."

Toggle the "Large Text" switch to the "On" position.

Use the slider to adjust the font size to your desired level.

- If you are using an older version of Ubuntu that does not have the Universal Access option in the Settings app, you can still adjust the font size using the following steps:

Replace <scaling_factor> with the value you want to set for the font size. For example, if you want to increase the font size by 50%, you can set the scaling factor to 1.5.

gsettings set org.gnome.desktop.interface text-scaling-factor <scaling_factor>

gsettings set org.gnome.desktop.interface text-scaling-factor 0.75
