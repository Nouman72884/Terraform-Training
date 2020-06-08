resource "aws_db_subnet_group" "db-subnet" {
  name        = "${terraform.workspace}-${var.NAME}-db-subnet"
  description = "RDS subnet group"
  subnet_ids  = [var.private-subnet-id-1,var.private-subnet-id-2]
}

resource "aws_db_parameter_group" "db-parameters" {
  name        = "${terraform.workspace}-${var.NAME}-db-parameters"
  family      = "mysql5.7"
  description = "DB parameter group"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

resource "aws_db_instance" "mysqldb" {
  allocated_storage       = 8 # 100 GB of storage, gives us more IOPS than a lower number
  max_allocated_storage   = 20
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro" # use micro if you want to use the free tier
  identifier              = "mysqldb"
  name                    = var.DB_NAME
  username                = var.RDS_USERNAME           # username
  password                = var.RDS_PASSWORD # password
  db_subnet_group_name    = aws_db_subnet_group.db-subnet.name
  parameter_group_name    = aws_db_parameter_group.db-parameters.name
  multi_az                = "true" # set to true to have high availability: 2 instances synchronized with each other
  vpc_security_group_ids  = [var.db-security-group-id]
  storage_type            = "gp2"
  backup_retention_period = 30                                          # how long youâ€™re going to keep your backups
  #availability_zone       = data.aws_availability_zones.available.names # prefered AZ
  skip_final_snapshot     = true                                        # skip final snapshot when doing terraform destroy
  tags = {
    Name = "db-instance"
  }
}

