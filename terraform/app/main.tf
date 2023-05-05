terraform {
  required_version = "~> 1.4.0"

  backend "s3" {
    bucket = "checkip-tfstates"
    region = "us-east-1"
    key    = "app/terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.66.0"
    }
  }
}
