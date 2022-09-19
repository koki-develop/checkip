terraform {
  backend "s3" {
    bucket = "checkip-tfstates"
    region = "us-east-1"
    key    = "app/terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.31.0"
    }
  }
}
