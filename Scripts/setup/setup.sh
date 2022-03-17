#!/bin/sh

# UPDATE/INSTALL PACKAGES
apt update
apt upgrade -y
apt install python3-pip	-y
apt install conntrack
apt install snap -y


# #####################################################
# CHECK DOCKER INSTALL ********
# #####################################################

which docker-compose &> /dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: docker-compose is not installed."
    exit 1
fi


# #####################################################
# CHECK DOCKER COMPOSE INSTALL
# #####################################################

which docker-compose &> /dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: docker-compose is not installed."
    exit 1
fi


# #####################################################
# CHECK AWS INSTALL ********
# #####################################################

which docker-compose &> /dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: docker-compose is not installed."
    exit 1
fi


# #####################################################
# CHECK GCLOUD INSTALL ********
# #####################################################

which docker-compose &> /dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: docker-compose is not installed."
    exit 1
fi


# #####################################################
# CHECK ANSIBLE INSTALL ********
# #####################################################

which docker-compose &> /dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: docker-compose is not installed."
    exit 1
fi


# #####################################################
# CHECK MINIKUBE INSTALL ********
# #####################################################

which docker-compose &> /dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: docker-compose is not installed."
    exit 1
fi


# #####################################################
# CHECK KIND INSTALL ********
# #####################################################

which docker-compose &> /dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: docker-compose is not installed."
    exit 1
fi


# #####################################################
# CHECK K3 INSTALL ********
# #####################################################

which docker-compose &> /dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: docker-compose is not installed."
    exit 1
fi

