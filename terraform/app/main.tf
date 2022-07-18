terraform {
  backend "s3" {
    bucket  = "checkip-tfstates"
    region  = "us-east-1"
    key     = "terraform.tfstate"
    profile = "default"
  }
}
