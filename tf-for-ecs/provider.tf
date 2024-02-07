# Configure required providers
terraform {
  required_providers {
    # Docker provider configuration
    docker = {
      source  = "kreuzwerker/docker"  # Provider source
      version = "3.0.2"            
    }
    # AWS provider configuration
    aws = {
      source  = "hashicorp/aws"       # Provider source
      version = "5.0"      
    }
  }
}

# Define providers
# Docker provider block
provider "docker" {}

# AWS provider block
provider "aws" {
  # Configure AWS region dynamically using a variable
  region     = var.aws_region
  # AWS access key obtained from a variable
  access_key = var.aws_access_key
  # AWS secret key obtained from a variable
  secret_key = var.aws_secret_key
}
