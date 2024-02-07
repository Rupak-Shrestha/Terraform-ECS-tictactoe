# ECS Cluster Configuration

# Create an ECS cluster named "cluster"
resource "aws_ecs_cluster" "cluster" {
  name = "cluster"  # Name of the ECS cluster

  # Configure container insights setting
  setting {
    name  = "containerInsights"  # Name of the setting
    value = "enabled"            # Value for the setting
  }
}

# ECS Task Definition Configuration

# Define an ECS task definition named "service"
resource "aws_ecs_task_definition" "task" {
  family                   = "service"                      # Family name of the task definition
  network_mode             = "awsvpc"                       # Network mode for the task
  requires_compatibilities = ["FARGATE", "EC2"]             # Compatibility requirements
  cpu                      = 512                            # CPU units for the task
  memory                   = 2048                           # Memory for the task in MiB
  container_definitions    = <<DEFINITION                   # Container definitions in JSON format
  [
    {
      "name"      : "tictactoe-app",                               # Name of the container
      "image"     : "rupaks/tictactoe-app:latest",                 # Docker image for the container
      "cpu"       : 512,                                    # CPU units for the container
      "memory"    : 2048,                                   # Memory for the container in MiB
      "essential" : true,                                   # Indicates if the container is essential for the task
      "portMappings" : [                                    # Port mappings for the container
        {
          "containerPort" : 80,                             # Container port
          "hostPort"      : 80                              # Host port
        }
      ]
    }
  ]
  DEFINITION
}

# ECS Service Configuration

# Define an ECS service named "service"
resource "aws_ecs_service" "service" {
  name             = "service"                             # Name of the ECS service
  cluster          = aws_ecs_cluster.cluster.id             # ID of the ECS cluster
  task_definition  = aws_ecs_task_definition.task.id        # ID of the ECS task definition
  desired_count    = 1                                      # Desired number of tasks to run
  launch_type      = "FARGATE"                              # Launch type for the service
  platform_version = "LATEST"                               # Platform version for the service

  # Network configuration for the service
  network_configuration {
    assign_public_ip = true                                 # Assign public IP addresses to tasks
    security_groups  = [aws_security_group.sg.id]           # Security groups for the tasks
    subnets          = [aws_subnet.subnet.id]               # Subnets for the tasks
  }

  # Ignore changes to the task definition during lifecycle events
  lifecycle {
    ignore_changes = [task_definition]
  }
}
