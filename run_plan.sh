#!/usr/bin/env bash
terraform init -backend-config 'bucket=tf-application' -backend-config 'key=infrastructure.tfstate' -backend-config 'region=us-east-1'
terraform plan -var-file=infrastructure.tfvars -state=infrastructure.tfstate