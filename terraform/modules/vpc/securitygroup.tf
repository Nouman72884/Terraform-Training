resource "aws_security_group" "instance-security-group" {
  vpc_id      = aws_vpc.vpc.id
  name        = "${terraform.workspace}-${var.NAME}-SG"
  description = "security group that allows all ingress and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.alb-security-group.id]
  }
  tags = {
    Name = "${terraform.workspace}-${var.NAME}-SG"
  }
}

resource "aws_security_group" "alb-security-group" {
  vpc_id      = aws_vpc.vpc.id
  name        = "${terraform.workspace}-${var.NAME}-ALB SG"
  description = "security group that allows all ingress and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${terraform.workspace}-${var.NAME}-ALB SG"
  }
}

resource "aws_security_group" "db-security-group" {
  vpc_id      = aws_vpc.vpc.id
  name        = "${terraform.workspace}-${var.NAME}-DB SG"
  description = "security group that allows all ingress and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.alb-security-group.id]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${terraform.workspace}-${var.NAME}-DB SG"
  }
}

