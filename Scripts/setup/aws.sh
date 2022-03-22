#!/bin/sh

#///////////////////////////////////////////////////////////////////
#///////////////////////////////////////////////////////////////////
# AWS SETUP

sudo yum -y update          # Install the latest system updates.
sudo yum -y install aws-cli # Install the AWS CLI.
aws --version               # Confirm the AWS CLI was installed.