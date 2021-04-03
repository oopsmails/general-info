
# Install WebSphere on Linux

- Ref:
https://garden114.blogspot.com/2020/07/was-websphere-v9051-basic-install-guide.html

WAS | WebSphere v9.0.5.1 Basic install guide

WebSphere v9.0.5.1 Basic install guide

OS : CentOS 7 3.10.0-957.el7.x86_64


## IM imcl install
*tip. Check the package name simply {img_file}/Offerings*

### IM install
`./imcl install com.ibm.cic.agent -repositories "/sw/img/im/repository.config" -installationDirectory "/sw/IBM/InstallationManager/eclipse" -sharedResourcesDirectory "/sw/IBM/IMShared" -acceptLicense -sP`

*In this guide, use the existing Installation Manager.*

### WebSphere install

```
cd /sw/IBM/InstallationManager/eclipse/tools

./imcl install com.ibm.websphere.BASE.v90_9.0.5001.20190828_0616 -repositories "/sw/img/base" -installationDirectory "/sw/was/AppServer9" -sharedResourcesDirectory "/sw/IBM/IMShared" -acceptLicense -properties cic.selector.nl=ko -sP
```

*tip. Starting with websphere version 9.0, Java installation should also proceed*.

```
#install
./imcl install com.ibm.websphere.BASE.v90_9.0.5001.20190828_0616 com.ibm.java.jdk.v8_8.0.5041.20190924_1031 -repositories "/sw/img/base","/sw/img/sdk" -installationDirectory "/sw/was/AppServer9" -sharedResourcesDirectory "/sw/IBM/IMShared" -acceptLicense -properties cic.selector.nl=ko -sP

#fix install
./imcl install com.ibm.websphere.BASE.v90_9.0.5003.20200226_0941 -acceptLicense -installationDirectory "/sw/was/AppServer9" -repositories "/sw/img/fixwas"  -sP
```

### IBM HTTPServer install

```
./imcl install "com.ibm.websphere.IHS.v90_9.0.5001.20190828_0616" "com.ibm.java.jdk.v8_8.0.5041.20190924_1031" -repositories "/sw/img/ihs","/sw/img/sdk"  -installationDirectory "/sw/web/IHS9" -sharedResourcesDirectory "/sw/IBM/IMShared" -acceptLicense -sP -properties user.ihs.httpPort="80"

#fix
./imcl install com.ibm.websphere.IHS.v90_9.0.5003.20200226_0941 -acceptLicense -installationDirectory "/sw/web/IHS9" -repositories "/sw/img/fixweb" -sP
Plugins install
```

### Plugins install

```
./imcl install com.ibm.websphere.PLG.v90_9.0.5001.20190828_0616 com.ibm.java.jdk.v8_8.0.5041.20190924_1031 -repositories "/sw/img/plg","/sw/img/sdk"  -installationDirectory "/sw/web/Plugins9" -sharedResourcesDirectory "/sw/IBM/IMShared" -acceptLicense -sP

#fix
./imcl install com.ibm.websphere.PLG.v90_9.0.5003.20200226_0941 -acceptLicense -installationDirectory "/sw/web/Plugins9" -repositories "/sw/img/fixweb" -sP
```

### version Info

- imcl listInstalledPackages
- {install_home}/bin/versionInfo.sh


