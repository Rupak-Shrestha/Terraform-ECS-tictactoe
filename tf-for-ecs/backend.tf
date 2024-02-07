terraform {
  backend "s3" {
    bucket = "tf-backend-for-ecs-tictactoe"
    key    = "ecs/terraform.tfstate"
    region = "ca-central-1"
  }
}