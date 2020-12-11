#!/usr/bin/env bash
terraform apply -var-file=infrastructure.tfvars -state=infrastructure.tfstate