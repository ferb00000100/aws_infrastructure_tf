//module "dynamodb"{
//  source = "../terraform_modules/infrastructure_backends"
//  bucket = ""
//  dynamodb_table = ""
//  namespace = var.namespace
//  service = var.namespace
//}

module "infrastructure_provider" {
  source = "../terraform_modules/infrastructure_aws_defaults"
  aws_access_key = ""
  aws_secret_access_key = ""
  region = var.region
}

module "infrastructure_networking" {
  source = "../terraform_modules/infrastructure_networking"
  cidr_block = var.cidr_block
  availability_zone = var.availability_zone
  vpc_id = var.vpc_id
  namespace = var.namespace
  owner = var.owner
  email = var.email
}

module "infrastructure_instances" {
  source = "../terraform_modules/infrastructure_instances"
  template = file("${path.module}/templates/instance_config.sh.tpl")
  environment = var.environment
  namespace = var.namespace
  public_key_path = file(var.public_key_path)
  private_key_path = file(var.private_key_path)
  ami = var.ami
  instance_type = var.instance_type
  aws_subnet_id = module.infrastructure_networking.aws_subnet_id
  aws_security_group_id = module.infrastructure_security_groups.infrastructure_security_group_id
  email = var.email
}

module "infrastructure_security_groups" {
  source = "../terraform_modules/infrastructure_security"
  vpc_id = var.vpc_id
  environment = var.environment
  cidr_block_priv = var.cidr_block_priv
  owner = var.owner
  aws_security_group_id = ""
  email = var.email
}