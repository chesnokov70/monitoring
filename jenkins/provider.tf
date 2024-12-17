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
  required_version = ">= 1.10.2"

  backend "s3" {
    bucket = "sergei-chesnokov-s3-backet"           # setup your s3 bucket name
    key    = "jenkins_ru/terraform.tfstate" # setup your s3 bucket name
    region = "us-east-1"
  }
}

provider "aws" {
  region  = var.region
  profile = "default"
}