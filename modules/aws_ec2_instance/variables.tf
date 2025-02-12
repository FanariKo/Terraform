variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "name_instance" {
  description = "Name instance"
  type        = string
  default     = "instance"
}

variable "aws_security_group" {
  description = "Name sg"
  type        = string
  default     = "default"
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

/*variable "secret_db_password" {
  description = "Пароль для базы данных"
  type        = string
}

variable "secret_api_key" {
  description = "API ключ"
  type        = string
}
*/
