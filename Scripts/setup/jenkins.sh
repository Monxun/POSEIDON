#!/bin/bash

echo "POSEIDON: Initialize..."

# CHECK DOCKER
which docker &> /dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: docker is not installed."
    exit 1
fi

# CHECK DOCKER COMPOSE
which docker-compose &> /dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: docker-compose is not installed."
    exit 1
fi

# CHECK AWS CLI
which aws &> /dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: AWS-CLI is not installed."
    exit 1
fi

# CHECK TERRAFORM
which aws &> /dev/null

if [ $? -ne 0 ]; then
    echo "ERROR: AWS-CLI is not installed."
    exit 1
fi