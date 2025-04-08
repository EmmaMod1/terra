resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier  = data.aws_subnets.default.ids

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}


# Déclaration du provider AWS
provider "aws" {
  region = "us-east-1"  # Remplace par la région que tu utilises
}

# Déclaration de la ressource Launch Configuration
resource "aws_launch_configuration" "example" {
  name          = "example-launch-config"
  image_id      = "ami-0fb653ca2d3203ac1"  # Remplace par une AMI valide
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

# Déclaration de la source de données des subnets
data "aws_subnets" "default" {
  filter {
    name   = "tag:Name"
    values = ["terraform-asg-sub-example"]
 # Remplace par tes tags ou critères spécifiques
  }
}

