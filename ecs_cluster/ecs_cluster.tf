resource "aws_ecs_cluster" "ecs_cluster" {
  name = "demo_ecs_cluster"

}

resource "aws_ecs_task_definition" "task_def" {
  family                   = "sonarqube-task-def"
  network_mode             = "awsvpc" #Fargate only supports network mode ‘awsvpc’
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.task_role.arn  #Fargate requires task definition to have execution role ARN to support ECR images
  execution_role_arn       = aws_iam_role.task_role.arn

//  execution_role_arn       = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
  cpu = "512"

  memory                = "1024" #ClientException: Fargate requires that 'cpu' be defined at the task level.
  container_definitions = <<EOF
    [
      {
        "name": "sonarqube",
        "image": "12345678910.dkr.ecr.ap-south-1.amazonaws.com/sonarqube:latest",
        "memory": 1024,
        "cpu": 512,
        "essential": true,
        "portMappings": [
          {
            "containerPort": 9000,
            "hostPort": 9000
          }
        ]
      }
    ]
    EOF

  ## any name for task defination
}

resource "aws_ecs_service" "demo-svc" {
  name            = "sonarqube-svc"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_def.arn
  desired_count   = 1 #Create service with 1 instances to start
  network_configuration {
//    subnets = ["subnet-0f0e0c96304a5a5c2","subnet-06632f6ec4033433d","subnet-0b138b0c069b00a26"]
    subnets         = data.aws_subnets.subnets.ids
  }
}
data "aws_subnets" "subnets" {} ## ---> this will help to get the existing resources but not under the control of terraform

output "subnets" {
  value = data.aws_subnets.subnets.ids
}