# ECS Cluster Configuration

# Create an ECS cluster named "cluster"
resource "aws_ecs_cluster" "cluster" {
  name = "cluster" # Name of the ECS cluster

  # Configure container insights setting
  setting {
    name  = "containerInsights" # Name of the setting
    value = "enabled"           # Value for the setting
  }
}

# ECS Task Definition Configuration

# Define an ECS task definition named "service"
resource "aws_ecs_task_definition" "task" {
  family                   = "service"          # Family name of the task definition
  network_mode             = "awsvpc"           # Network mode for the task
  requires_compatibilities = ["FARGATE", "EC2"] # Compatibility requirements
  cpu                      = 512                # CPU units for the task
  memory                   = 2048               # Memory for the task in MiB
  container_definitions = jsonencode([
    {
      "name" : "tictactoe-app",
      "image" : "rupaks/tictactoe-app:latest",
      "cpu" : 512,
      "memory" : 2048,
      "essential" : true,
      "portMappings" : [
        {
          "containerPort" : 80,
          "hostPort" : 80
        }
      ]
    }
  ])
}

# ECS Service Configuration

# Define an ECS service named "service"
resource "aws_ecs_service" "service" {
  name             = "service"                       # Name of the ECS service
  cluster          = aws_ecs_cluster.cluster.id      # ID of the ECS cluster
  task_definition  = aws_ecs_task_definition.task.id # ID of the ECS task definition
  desired_count    = 1                               # Desired number of tasks to run
  launch_type      = "FARGATE"                       # Launch type for the service
  platform_version = "LATEST"                        # Platform version for the service

  # Network configuration for the service
  network_configuration {
    assign_public_ip = true                       # Assign public IP addresses to tasks
    security_groups  = [aws_security_group.sg.id] # Security groups for the tasks
    subnets          = [aws_subnet.subnet.id]     # Subnets for the tasks
  }

  # Ignore changes to the task definition during lifecycle events
  lifecycle {
    ignore_changes = [task_definition]
  }
}
