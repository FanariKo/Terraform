# 1. Создаем EC2-инстанс
resource "aws_instance" "dev_ops_week2" {
  ami                  = var.ami_id
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  tags = {
    Name = var.name_instance
  }
  instance_type   = var.instance_type
  key_name        = "terraform_ec2_key" #aws_key_pair.terraform_ec2_key.key_name
  user_data       = file("${path.module}/script.sh")
  security_groups = [var.aws_security_group]
}





#Codify instance profile

resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.role.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

#Secret Manager
data "aws_iam_policy_document" "secrets_manager_policy" {
  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:PutSecretValue",
      "secretsmanager:ListSecrets"
    ]

    resources = ["*"] # Укажите конкретные ресурсы, если это необходимо
  }
}

resource "aws_iam_role_policy" "secrets_manager_policy" {
  name = "secrets_manager_policy"
  role = aws_iam_role.role.id

  policy = data.aws_iam_policy_document.secrets_manager_policy.json
}

resource "aws_iam_role" "role" {
  name               = "test_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
