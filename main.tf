provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "dev_ops_week2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.terraform_ec2_key.key_name
  user_data                   = file("${path.module}/script.sh")
  associate_public_ip_address = true
  security_groups             = [aws_security_group.example_sg.name]
}

resource "aws_security_group" "example_sg" {
  name        = "example-security-group"
  description = "Allow SSH (home IP), HTTP, and HTTPS inbound; all traffic outbound"
  vpc_id      = var.vpc_id

  # Входящие правила (ingress)
  ingress {
    description = "Allow SSH from home IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.home_ip]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Исходящие правила (egress)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_file)
}
