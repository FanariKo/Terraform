variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-09a9858973b288bdd"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "terraform_ec2_key"
}

variable "public_key_file" {
  description = "Path to the public key file"
  type        = string
  default     = "terraform_ec2_key.pub"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-0b6c4a4da62ad49b6"
}

variable "home_ip" {
  description = "Your home IP address for SSH access"
  type        = string
  default     = "91.224.45.78/32"
}
