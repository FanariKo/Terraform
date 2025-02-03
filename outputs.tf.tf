output "instance_ip" {
  value       = aws_instance.dev_ops_week2.public_ip
  description = "Public IP address of the EC2 instance"
}
