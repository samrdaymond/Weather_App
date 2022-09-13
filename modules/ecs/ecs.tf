# create security group for ecs

resource "aws_security_group" "weather-app-ecs-sg" {
  description = "weather-app-ecs-sg"
  vpc_id = aws_vpc.samrdaymond_wa_vpc.id
  ingress = [ {
    description = "ALB to ECS traffic"
    security_groups = aws_security_groups.weather-app-alb-sg.id
    from_port = 80
    to_port = 80
    protocol = "HTTP"    
  } ]
}

#create role for ecs ecr access
resource "aws_iam_role" "samrdaymond_Ecs_EcrAccessRole" {
  name = "samrdaymondEcsEcrAccess"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:BatchCheckLayerAvailability",
                "ecr:BatchGetImage",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetAuthorizationToken"
            ],
            "Resource": "*"
        }
    ]
  })
}

#create ecs execution role and policy

resource "aws_iam_role" "samrdaymondEcsExecutionRole" {
  name = "samrdaymondEcsExecutionRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_ecs_cluster" "samrdaymond_wa_ecs_cluster" {
  name = "weather-app-cluster"
}
#creation of ecs task definition

resource "aws_ecs_task_definition" "samrdaymond_wa_ecs_td" {
  name = "weather-app"
  network_mode = "awsvpc"
  requires_compatibilities = ["Fargate"]
  family = "weather-app-fam"
  cpu = 256
  memory = 512
  execution_role_arn = aws_iam_role.samrdaymondEcsExecutionRole.arn
  task_role_arn = aws_iam_role.samrdaymondEcsExecutionRole.arn
  container_definitions = jsonencode([
    {
            "name": "weather-app",
            "image": "{ECR-repo-uri}",
            "portMappings": [
                {
                    "protocol": "tcp",
                    "containerPort": 3000,
                    "hostPort": 3000
                }
            ]
    }
  ])
  tags = {
    Name        = "${var.name}-task-${var.environment}"
    Environment = var.environment
  }
}

#creation of ecs service

resource "aws_ecs_service" "samrdaymond_wa_ecsservice" {
  name                               = "weather-app-service"
  cluster                            = aws_ecs_cluster.samrdaymond_wa_ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.samrdaymond_wa_ecs_td.arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  iam_role                           = aws_iam_role.samrdaymondEcsExecutionRole.arn
  service_name                        = "weather-app-service"
  


  network_configuration {
    security_groups  = var.ecs_service_security_groups
    subnets          = "[aws_subnet.samrdaymond_wa_public_sub_a.id, aws_subnet.samrdaymond_wa_public_sub_b.id]"
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.aws_alb_target_group_arn
    container_name   = "${var.name}-container-${var.environment}"
    container_port   = var.container_port
  }

}