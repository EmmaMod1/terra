# Fournisseur AWS
provider "aws" {
  region = "us-east-1"  # Change la région si besoin
}

# VPC/Subnets (assure-toi que tu as bien des subnets taggés)
data "aws_subnets" "default" {
  filter {
    name   = "tag:Name"
    values = ["terraform-asg-sub-example"]  # Remplace par tes vrais tags de subnet
  }
}

# Launch Template
resource "aws_launch_template" "example" {
  name_prefix   = "example-launch-template-"
  image_id      = "ami-0c02fb55956c7d316"  # Amazon Linux 2 (valide en us-east-1)
  instance_type = "t2.micro"
}

# Auto Scaling Group
resource "aws_autoscaling_group" "example" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = data.aws_subnets.default.ids

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "terraform-asg-instance"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true
  wait_for_capacity_timeout = "0"
}
