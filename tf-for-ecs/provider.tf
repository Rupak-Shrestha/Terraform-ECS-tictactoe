# Configure required providers
terraform {
  required_providers {
    # Docker provider configuration
    docker = {
      source  = "kreuzwerker/docker" # Provider source
      version = "3.0.2"
    }
    # AWS provider configuration
    aws = {
      source  = "hashicorp/aws" # Provider source
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
  region = "ca-central-1"
}
