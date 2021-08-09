resource "aws_instance" "my_ec2_wp" {
  ami                    = "ami-04876f29fd3a5e8ba"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg_wp.id]
  key_name               = aws_key_pair.my_sshkey.key_name

  connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = file("./my_sshkey")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "wpservers.yaml"
    destination = "/home/ubuntu/wpserver.yaml"

  }
  provisioner "local-exec" {
    command = <<-EOF
		ssh-keyscan -t ssh-rsa ${self.public_ip} >> ~/.ssh/known_hosts
		echo "${self.public_ip} ansible_ssh_user=${var.ssh_user} ansible_ssh_private_key_file=./my_sshkey" > inventory.ini
		 echo  "mysql_db: ${aws_db_instance.my_db_mysql.name}\nmysql_user: ${aws_db_instance.my_db_mysql.username}\nmysql_pw: ${aws_db_instance.my_db_mysql.password}\nmysql_host: ${aws_db_instance.my_db_mysql.endpoint}\napache_port: ${var.apache_port}" > group_vars/all.yaml
	EOF
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory.ini wpservers.yaml -b"
  }
  depends_on = [aws_db_instance.my_db_mysql]
}

resource "aws_db_instance" "my_db_mysql" {
  allocated_storage      = 5
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = var.mysql_db
  username               = var.mysql_user
  password               = var.mysql_passwd
  parameter_group_name   = "default.mysql5.7"
  port                   = var.mysql_port
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg_wp.id]
}

resource "aws_key_pair" "my_sshkey" {
  key_name   = "my_sshkey"
  public_key = file("./my_sshkey.pub")
}
