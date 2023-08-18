#!/bin/bash

set -a # Enable automatic exporting of variables
source .env # Load environment variables from .env file

LAB_FILE=$1

Current_Dir=$(pwd)

cd ./main_logic

# Excetute terraform script

terraform init -upgrade
terraform apply -var="access_key=$ACCESS_KEY" -var="secret_key=$SECRET_KEY" -var="lab_file=$LAB_FILE"