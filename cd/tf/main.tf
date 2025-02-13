terraform {
  required_version = ">= 0.14"
}
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "eu-central-1"
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

resource "aws_launch_configuration" "lc" {
  image_id      = var.ami_id
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.elbsg.id}"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
  name                 = "terraform-asg-node-app-${aws_launch_configuration.lc.name}"
  launch_configuration = "${aws_launch_configuration.lc.name}"
  availability_zones = ["eu-central-1a", "eu-central-1b"]
  min_size             = 2
  max_size             = 3

  load_balancers = ["${aws_elb.web_elb.id}"]
  health_check_type = "ELB"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "elbsg" {
  name = "security_group_for_elb"
  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "web_elb" {
  name = "web-elb"
  #security_groups = var.security_groups
  security_groups = ["${aws_security_group.elbsg.id}"]
  # subnets = var.pub_subnets
  availability_zones = ["eu-central-1a", "eu-central-1b"]
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