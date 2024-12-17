terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.5"
    }
  }

  backend "s3" {
    bucket = "sergei-chesnokov-s3-backet"           # setup your s3 bucket name
    key    = "grafana/terraform.tfstate" # setup your s3 bucket name
    region = "us-east-1"
  }
}

provider "aws" {
  region  = var.region
  profile = "default"
}