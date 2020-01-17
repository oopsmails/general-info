
https://medium.com/capital-one-tech/how-to-make-swagger-codegen-work-for-your-team-32194f7d97e4


- git clone https://github.com/swagger-api/swagger-codegen.git

- mvn clean install

- If this completes successfully, you’ll see the swagger-codegen-cli.jar created in the directory modules/swagger-codegen-cli/target/.

- java -jar swagger-codegen-cli.jar generate -i petstore.yaml -l swift4 -Dmodels

java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate \
  -i http://petstore.swagger.io/v2/swagger.json \
  -l java \
  -o samples/client/petstore/java

- 

java -jar /c/GitHubOthers/swagger-codegen/modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate \
  -i petstore.yaml \
  -l java \
  -o samples/client/petstore/java



--- orig

--- test-master
