terraform {
  backend "s3" {
    bucket = "tf_application"
    key    = "infrastructure.tfstate"
    region = "us-east-1"
    dynamodb_table = "infrastructure_terraform-running-locks"
    encrypt = true
  }
}

// UNCOMMENT IF TABLE HAS NOT ALREADY BEEN CREATED
//resource "aws_dynamodb_table" "terraform_locks" {
//  name         = "${var.namespace}_terraform-running-locks"
//  billing_mode = "PAY_PER_REQUEST"
//  hash_key     = "LockID"
//  attribute {
//    name = "LockID"
//    type = "S"
//  }
//}
