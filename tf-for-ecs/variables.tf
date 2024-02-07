# Provider Configuration

# Define a variable for AWS region
variable "aws_region" {
  description = "aws region"    # Description of the variable
  type        = string          # Type of the variable
  default     = "ca-central-1a" # Default value for the variable
}

# Define a variable for VPC CIDR block
variable "vpc_cidr" {
  description = "CIDR block for main" # Description of the variable
  type        = string                # Type of the variable
  default     = "10.0.0.0/16"         # Default value for the variable
}

# Define a variable for availability zones
variable "availability_zones" {
  type    = string          # Type of the variable
  default = "ca-central-1a" # Default value for the variable
}
