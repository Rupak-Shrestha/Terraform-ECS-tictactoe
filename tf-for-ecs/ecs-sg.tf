# Security Group Configuration

# Create an AWS security group for ECS
resource "aws_security_group" "sg" {
  name   = "ecs-sg"                # Name of the security group
  vpc_id = aws_vpc.main.id         # Associate the security group with the VPC

  # Define ingress rules
  ingress {
    from_port   = 80                # Allow incoming traffic on port 80
    to_port     = 80                # Allow incoming traffic on port 80
    protocol    = "tcp"             # Protocol for the rule (TCP)
    self        = false             # Whether to allow traffic from the security group itself
    cidr_blocks = ["0.0.0.0/0"]     # Allowed source CIDR blocks (anywhere)
    description = "http"            # Description for the rule
  }

  # Define egress rules
  egress {
    from_port   = 0                 # Allow all outgoing traffic
    to_port     = 0                 # Allow all outgoing traffic
    protocol    = "-1"              # Protocol for the rule (all)
    cidr_blocks = ["0.0.0.0/0"]     # Allowed destination CIDR blocks (anywhere)
  }
}
