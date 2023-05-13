resource "aws_instance" "MyAmazonEC2" {
  ami                    = "ami-007855ac798b5175e"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_default_security_group.default-sg.id]

  subnet_id = aws_subnet.public_subnet.id
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              exec 2> /var/log/user-data.log
              sudo apt update -y
              sudo apt-get install mysql-client -y
              dbendpoint=${element(split(":", aws_db_instance.mysql_db.endpoint), 0)}
              dbuser=${aws_db_instance.mysql_db.username}
              dbpass=${aws_db_instance.mysql_db.password}
              sudo apt install nginx -y
              sudo systemctl enable nginx
              echo "[client]" >> mysql.conf
              echo host=$dbendpoint >> mysql.conf
              echo password=$dbpass >> mysql.conf
              echo user=$dbuser >> mysql.conf
              sudo chmod 777 /var/www/html/index.nginx-debian.html
              export MYSQL_CMD="mysql --defaults-extra-file=mysql.conf"
              if $MYSQL_CMD -e "SHOW DATABASES;"; then
                echo "Database connection successful!" > /var/www/html/index.nginx-debian.html
              else
                echo "Database connection error." > /var/www/html/index.nginx-debian.html
              fi
              EOF

  tags = {
    "Name" = "${var.env_prefix}-Ubuntu-EC2"
  }
}
