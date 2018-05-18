#!/bin/bash

# Set max JVM heap size for maven
MAVEN_OPTS='-Xmx512m'

# Set all variables
ACADEMI_CO_NETWORK='academi_co_network'

IMAGE_DB='academi_co_mysql'
IMAGE_APPSERVER='academi_co_wildfly'

DOCKER_DB='concealed_cader' # 172.18.0.4
DOCKER_DB_IT='shady_selimi' # 172.18.0.3
DOCKER_APPSERVER='cheeky_binko' # 172.18.0.2

DOCKER_DEPLOY='/tmp/docker-deploy'

# Scripts: script.sh network image container [...]



printf "\n ---------------- Create /tmp/docker-deploy directory ---------------- \n\n"

if [ ! -d /tmp/docker-deploy ]; then
  mkdir /tmp/docker-deploy
fi

printf "\n ---------------- Launch network ---------------- \n\n"

if [ !"$(docker network ls -q -f name=$ACADEMI_CO_NETWORK)" ]; then
     docker network create --subnet 172.18.0.0/16 $ACADEMI_CO_NETWORK
fi

# Launch the containers
./Jenkins/Scripts/Database/runDatabaseTests.sh \
    $ACADEMI_CO_NETWORK $IMAGE_DB $DOCKER_DB_IT
./Jenkins/Scripts/Database/runDatabase.sh \
    $ACADEMI_CO_NETWORK $IMAGE_DB $DOCKER_DB
./Jenkins/Scripts/Appserver/runAppServer.sh \
    $ACADEMI_CO_NETWORK $IMAGE_APPSERVER $DOCKER_APPSERVER $DOCKER_DB $DOCKER_DB_IT

printf "\n ---------------- Build Maven project ---------------- \n\n"

mvn -B -DskipTests -f academi-co/pom.xml clean package

printf "\n ---------------- Launch Tests ---------------- \n\n"

mvn -f academi-co/pom.xml test

# Kill all test containers if required
if [[ -n $1 ]]; then
   if [[ $1 != "--no-kill" ]]; then
      ./Jenkins/Scripts/Database/killDatabaseTests.sh $DOCKER_DB_IT
   fi
else
   ./Jenkins/Scripts/Database/killDatabaseTests.sh $DOCKER_DB_IT
fi

# Deploy the project
Jenkins/Scripts/deploy.sh $DOCKER_DEPLOY
