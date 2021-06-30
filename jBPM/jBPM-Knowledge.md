
- [Learning jBPM](#learning-jbpm)
  - [Installation](#installation)


# Learning jBPM

- Ref

https://www.youtube.com/watch?v=sJ9YUzz2PGA

## Installation


1. Download and unzip it.
2. On Linux/Mac, run jbpm-server/bin/standalone.sh
3. On Windows, run jbpm-server/bin/standalone.bat
4. Open browser and go to http://localhost:8080/business-central
5. Login/password wbadmin/wbadmin

```
<system-properties>
    <property name="org.kie.server.id" value="sample-server"/>
............
    <property name="jboss.as.management.blocking.timeout" value="3600"/>  <-------------------- add this line
</system-properties>
```


