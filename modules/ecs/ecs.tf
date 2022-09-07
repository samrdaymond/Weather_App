#### creation of ecs to be completed next week


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

#create role for ecs ecr role
resource "aws_iam_role" "samrdaymond_ecs_ecrrole" {
  name = "ecs_ecr_role"
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

resource "aws_iam_rol" "samrdaymondEcsExecutionRole" {
  name = "samrdaymondEcsExecutionRole"
  assume_role_policy = jsonencode({
    
  }
  
}