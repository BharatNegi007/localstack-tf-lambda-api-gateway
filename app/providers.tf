terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.57.1"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
  shared_credentials_files = ["/Users/user/.aws/credentials"]
  profile                 = "default"
}

