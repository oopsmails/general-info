
project_dir=/c/GitHub/spring-cloud-microservices-all
dockerfile_dir=$project_dir/docker
config_server_dir=$project_dir/spring-cloud-microservices-configserver
config_server_jar=spring-cloud-microservices-configserver-1.0-SNAPSHOT.jar

cd $dockerfile_dir
cp $config_server_dir/target/$config_server_jar .
