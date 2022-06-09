docker-compose -f /home/albert/Documents/sharing/github/general-info/Jenkins/jenkins-docker-202111/docker-compose.yml up -d


docker-compose -f /home/albert/Documents/sharing/github/general-info/Jenkins/jenkins-docker-202111/docker-compose.yml start



Maven project Github-oopsmails-02-maven-project

- Has to be Maven project to show "Maven release build" checkbox

- Install "Git Parameter | Jenkins plugin" to show "jenkins maven release build git parameter"

release/1.0.0


-Darguments='-Dmaven.test.skip=true -DscmBranch=${GIT_BRANCH}' -Dresume=false release:clean release:prepare release:perform -DuseReleaseProfole=false -e




