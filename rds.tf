resource "aws_db_instance" "mysql_db" {
  instance_class        = "db.t3.micro"
  engine                = "mysql"
  engine_version        = "8.0.32"
  identifier            = var.rds_db_name
  allocated_storage     = 5
  max_allocated_storage = 10
  username              = var.rds_username
  password              = var.rds_password
  skip_final_snapshot   = true
  publicly_accessible   = false
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  tags = {
    Name = "${var.env_prefix}-RDS-${var.rds_db_name}"
  }
}