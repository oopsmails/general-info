- [TBC, Unit 8: jBPM GeneratePDFWorkitemHandler](#tbc-unit-8-jbpm-generatepdfworkitemhandler)
- [TBC, Unit 13: jBPM GeneratePDFWorkitemHandler](#tbc-unit-13-jbpm-generatepdfworkitemhandler)


### TBC, Unit 8: jBPM GeneratePDFWorkitemHandler

- Ref

https://www.youtube.com/watch?v=K1z-fmmnj8c&list=PLXj2dEEjI7TkyDxW10dp9E3ygwq6oYwT2&index=10

JBPM GeneratePDFWorkitemHandler | JBPM 7 Service Task Repository | Unit 8 | KIE TUTORIALS

- Content

You can register the GeneratePDFWorkitemHanlder by following way

1. Enable PDF WorkitemHandler from Custom Task Administration
2. Install PDF workitemhandler in project service tasks section
3. provide runtime artifact

groupId- org.jbpm.contrib- /groupId  
artifactId-pdf-workitem-/artifactId  
version7.42.0.Final/version  

useful link  
https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbXFJWldTakNYUjM5Vk4wMEkzenhGU2xsLXM4UXxBQ3Jtc0tuNHVPMFJqNE96LWxWMnlRRl84V29ST1VaOUt6b2NfclFTc3pGT25ZT1h2bnc0eXNST0JwZlUyUEhDbEJScmNPMHdQT0M1NV9WeTNlek9MZmhiZEdRR2QtOXB3NGhNcE00ZG5IYzc0MUZSeERjWmR1VQ&q=https%3A%2F%2Fgithub.com%2Fkiegroup%2Fjbpm-work-items%2Ftree%2Fmaster%2Fpdf-workitem

Github code  
https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqa2JlX3pQX0tlTWpWZFd4UFF3bng2M3NTY3YtZ3xBQ3Jtc0trMHhGVWJfWTI4SXdmNVM1VmtIZk51bDRoNElmb2JBaWVDczdIcUtvUWFMcVNnX1dlS0d6U1JxTWo4X2hObmFfM2oyY1hHSy1GblRqT2hQcmM0Ylo2SjlyOTRqdW1YcVBqcHhCYTdmZ1BMbGZCUEZ0Zw&q=https%3A%2F%2Fgithub.com%2Fkietutorials%2Fjbpm-examples%2Ftree%2Fmaster%2Funit8-pdfGeneratorProject




### TBC, Unit 13: jBPM GeneratePDFWorkitemHandler

- Ref

https://www.youtube.com/watch?v=aslrJcebxqs&list=PLXj2dEEjI7TkyDxW10dp9E3ygwq6oYwT2&index=15

jBPM KIE JAVA API | jBPM 7 Java API | Unit 13 | KIE TUTORIALS

- Content

You can use kie java api to deal with ProcessServicesClient, UserTaskServicesClient, RuleServicesClient, QueryServicesClient  

below properites are useful while creating KieServicesConfiguration  

URL : http://localhost:8080/kie-server/services/rest/server  
USERNAME : wbadmin  
PASSWORD : wbadmin  

git hub code:::  
https://github.com/kietutorials/jbpm-examples/tree/master/unit13-kieTutorialJavaAPI


- get info from *Manage Process Definitions*

  - startProcess example
```
KieServicesClient kieServicesClient = util.getKieServicesClient();
		ProcessServicesClient processClient = kieServicesClient.getServicesClient(ProcessServicesClient.class);
```

  - startTask
  - completeTask









