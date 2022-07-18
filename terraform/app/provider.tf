provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      App = "checkip"
    }
  }
}
