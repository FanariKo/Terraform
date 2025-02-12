output "instance_ip" {
  value       = aws_instance.dev_ops_week2.public_ip
  description = "Public IP address of the EC2 instance"
}
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}
