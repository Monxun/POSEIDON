#!/bin/sh

#///////////////////////////////////////////////////////////////////
#///////////////////////////////////////////////////////////////////
# SONARQUBE SETUP

# EXECUTE FROM HOST MACHINE OF JENKINS CONTAINER

docker exec -it jenkins bash
mkdir /var/jenkins_home
mkdir /var/jenkins_home/sonar-scanner

cd /var/jenkins_home/sonar-scanner

wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip
unzip sonar-scanner-cli-3.3.0.1492-linux.zip