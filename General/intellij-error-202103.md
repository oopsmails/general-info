
# Memo

## Java

### Intellij error

- intellij java.lang.NoClassDefFoundError: Could not initialize class org.codehaus.groovy.reflection.ReflectionCache

JDK14 which is not supported by grails 4.0.x. Use a LTS version such as Java 11 or 8. wait until grails updates to the latest

- Intellij version : IntelliJ IDEA 2020.3 (Community Edition) Build #IC-203.5981.155, built on December 1, 2020

    - Error :

java: You aren't using a compiler supported by lombok, so lombok will not work and has been disabled.
  Your processor is: com.sun.proxy.$Proxy24
  Lombok supports: sun/apple javac 1.6, ECJ
    
    - Solution: Using lombok 1.18.16 did not work for me. I added the argument below in the build process VM options in

-Djps.track.ap.dependencies=false
Setting:-

Build, Execution, Deployment -> Compiler -> Shared build process VM options

and it worked https://github.com/rzwitserloot/lombok/issues/2592



