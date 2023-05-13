terraform {
  backend "s3" {
    bucket = "<s3_bucket>"
    key = "<bucket>/state.tfstate"
    region = "<aws_region>"
    dynamodb_table = "<terraform_state_table>"
    encrypt        = true
    profile = "<aws_profile>"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = "<aws_profile>"
  region     = var.aws_region
}
