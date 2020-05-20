resource "aws_instance" "ec2-instance" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.AWS_INSTANCE_TYPE
  tags = {
    Name = "${terraform.workspace}-${var.EC2_MODULE_NAME}-instance"
  }
  # the VPC subnet
  subnet_id = var.private-subnet-1-id

  # the security group
  vpc_security_group_ids = [var.instance-security-group-id]

  # the public SSH key
  key_name = var.KEYPAIR_NAME
}

