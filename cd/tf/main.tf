
provider "aws" {
  profile    = "packer"
  region     = "ap-southeast-1"
}

resource "aws_launch_template" "web" {
  name_prefix = "web-"
  image_id = var.ami_id 
  instance_type = "t2.micro"
  key_name = "devops_training"
  vpc_security_group_ids = var.security_groups
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "web_elb" {
  name = "web-elb"
  security_groups = var.security_groups
  subnets = var.pub_subnets
  cross_zone_load_balancing   = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}

resource "aws_autoscaling_group" "web" {
  name = "web-asg"
  min_size             = var.min_capacity
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  health_check_type    = "ELB"
  load_balancers = [
    aws_elb.web_elb.id
  ]
   launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  vpc_zone_identifier  = var.pub_subnets
  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}
