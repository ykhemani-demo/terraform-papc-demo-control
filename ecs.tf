#### ecs task service defineition
resource "aws_ecs_task_definition" "service" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "second"
      image     = "node:4.8.1-slim"
      cpu       = 10
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 443
          hostPort      = 443
        }
      ]
    }
  ])
  tags = {
    yor_name  = "service"
    yor_trace = "b6ca94a9-0490-4f90-b15c-dbe4e37e8f34"
  }
}