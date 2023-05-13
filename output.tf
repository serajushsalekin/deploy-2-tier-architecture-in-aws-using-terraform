output "ec2-ip" {
  value = aws_instance.MyAmazonEC2.public_ip
}

output "vpc" {
  value = aws_vpc.vpc.id
}

output "azs" {
  value = local.azs
}

output "rds-endpoint" {
  value = aws_db_instance.mysql_db.endpoint
}