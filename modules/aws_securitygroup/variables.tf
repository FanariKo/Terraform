variable "sg_name" {
  description = "Имя security group"
  type        = string
  default     = "example-security-group"
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

/*variable "secret_db_password" {
  description = "Пароль для базы данных"
  type        = string
}

variable "secret_api_key" {
  description = "API ключ"
  type        = string
}*/
