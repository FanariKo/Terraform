provider "aws" {
  region = "eu-north-1"
}


module "ec2_instance" {
  source        = "../modules/aws_ec2_instance"
  ami_id        = "ami-09a9858973b288bdd"
  instance_type = "t3.micro"
  name_instance = "ec2_instance"
  key_name      = "terraform_ec2_key"
  //public_key_file    = "../modules/aws_ec2_instance/terraform_ec2_key.pub"
  aws_security_group = "sg_01"
}

module "module_aws_securitygroup" {
  source  = "../modules/aws_securitygroup"
  vpc_id  = "vpc-0b6c4a4da62ad49b6"
  home_ip = "91.224.45.78/32"
  sg_name = "sg_01"
}
