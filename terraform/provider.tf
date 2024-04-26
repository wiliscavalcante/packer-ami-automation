terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.46.0"
    }
  }
}

provider "aws" {
  # Define the AWS region where resources will be created
  region = "us-east-1"  # Ajuste conforme necessário
}
