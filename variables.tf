variable "aws_access_key" {
  description = "AWS access key for account"
}

variable "aws_secret_access_key" {
  description = "AWS secret key for account"
}

variable "environment" {
  description = "instance environment"
}

variable "namespace" {
  description = "Service Naming"
}

variable "public_key_path" {
  description = "The absolute path on disk to the SSH public key."
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "The absolute path on disk to the SSH private key."
  default     = "~/.ssh/id_rsa"
}

variable "ami" {
  description = "AWS Image"
}

variable "region" {
  default = ""
  description = "select region"
}

variable "instance_type" {
  description = "AWS Instance type"
}

variable "vpc_id" {
  description = "The VPC ID"
}

variable "availability_zone" {
  description = "The VPC ID"
}

variable "cidr_block" {
  description = "subnet block"
}

variable "owner" {
  description = "Instance Owner"
}

variable "cidr_block_priv" {
  description = "private access"
}

variable "email" {
  description = "Email address for owner tag"
}