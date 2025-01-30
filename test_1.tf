provider "aws" {
  region = "eu-north-1"
}


resource "aws_instance" "dev_ops_week2" {
  ami                         = "ami-09a9858973b288bdd"
  instance_type               = "t3.micro"
  key_name                    = "terraform_ec2_key"
  user_data                   = file("${path.module}/script.sh")
  associate_public_ip_address = true
  security_groups             = aws_security_group.example_sg.name
}

resource "aws_security_group" "example_sg" {
  name        = "example-security-group"
  description = "Allow SSH (home IP), HTTP, and HTTPS inbound; all traffic outbound"
  vpc_id      = "vpc-0b6c4a4da62ad49b6" # Укажите ID вашего VPC

  # Входящие правила (ingress)
  ingress {
    description = "Allow SSH from home IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["91.224.45.78/32"] # Замените <YOUR_HOME_IP> на ваш домашний IP
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Разрешить всем
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Разрешить всем
  }

  # Исходящие правила (egress)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Все протоколы
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = "terraform_ec2_key"
  public_key = file("terraform_ec2_key.pub")

}

output "instance_ip" {
  value       = aws_instance.dev_ops_week2
  description = "Public IP address of the EC2 instance"
}


