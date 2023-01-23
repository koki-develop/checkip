terraform {
  backend "s3" {
    bucket = "checkip-tfstates"
    region = "us-east-1"
    key    = "action/terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.51.0"
    }
  }
}
