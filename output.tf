output "ec2-public_ip" {
  value = aws_instance.my_ec2_wp.public_ip
}

output "rds-endpoint" {
  value = aws_db_instance.my_db_mysql.endpoint

}
