# modules/asg/main.tf
resource "aws_autoscaling_group" "example" {
  name                 = "example"
  max_size             = var.max_size
  min_size             = var.min_size
  health_check_grace_period = 300
  health_check_type    = "ELB"
  desired_capacity     = var.desired_capacity

  launch_configuration = aws_launch_configuration.example.id
  vpc_zone_identifier  = var.subnet_ids
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_configuration" "example" {
  image_id = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  # import this later via data source
  security_groups = [ aws_security_group.example.id ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "example_policy_up" {
  name                   = "example-policy-up"
  autoscaling_group_name = aws_autoscaling_group.example.name
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
}

resource "aws_cloudwatch_metric_alarm" "example_cpu_alarm_up" {
  alarm_name = "example_cpu_alarm_up"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  period = "60"
  statistic = "Average"
  threshold = "70"
  alarm_description = "Monitors CPU utilization"
  alarm_actions = [aws_autoscaling_policy.example_policy_up.arn]

  dimensions = {
    AutoScaleGroupName = aws_autoscaling_group.example.name
  }
}

resource "aws_autoscaling_policy" "example_policy_down" {
  name                   = "example-policy-down"
  autoscaling_group_name = aws_autoscaling_group.example.name
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
}

resource "aws_cloudwatch_metric_alarm" "example_cpu_alarm_down" {
  alarm_name = "example_cpu_alarm_down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  period = "60"
  statistic = "Average"
  threshold = "30"
  alarm_description = "Monitors CPU utilization"
  alarm_actions = [aws_autoscaling_policy.example_policy_up.arn]

  dimensions = {
    AutoScaleGroupName = aws_autoscaling_group.example.name
  }
}

# move this later
resource "aws_security_group" "example" {
  name = local.app

  vpc_id = aws_vpc.example.id # pretend this exists

  ingress {
    description      = "Allow inbound HTTPS traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow inbound HTTP traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
