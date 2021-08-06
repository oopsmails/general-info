# Elementary OS Tips


## Create an application desktop icon

- Ref:

https://elementaryos.stackexchange.com/questions/560/how-can-i-add-an-executable-file-to-the-dock


Create an application desktop-entry at /usr/share/applications/ with the name app-name.desktop with the following basic details:  

```
[Desktop Entry]
Version=1.0
Name=App Name
Exec=/dir/path/app/binary
Terminal=false
Icon=/icon/path/icon.png
Type=Application
```

To disable the errors windows related with certificates you can start Chrome from console and use this option: --ignore-certificate-errors.

```
[Desktop Entry]
Name=chrome
Exec=/usr/bin/google-chrome-stable --ignore-certificate-errors --incognito %u
NoDisplay=true
Terminal=false
Icon=google-chrome
Type=Application
MimeType=application/pdf;text/html;text/xml;application/xhtml_xml;image/webp;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;  
Action=new-window;new-private-window;
```

You can add entries like MimeType (complete-list) and Encoding (eg: UTF-8) optionally. For the app category (eg: Categories:Network;WebBrowser;IDE) check the short list below:  

AudioVideo, Audio, Video, Development, Education, Game, Graphics, Network, Office, Science, Settings, System, Utility  

edit: If you need to get administrator privileges explicitly (with sudo), install gksu and then use gksudo at exec  

Then there will be "Keep in dock" when right click



