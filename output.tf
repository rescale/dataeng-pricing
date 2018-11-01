output "bastion_connection_string" {
  value = "ec2-user@${aws_instance.bastion.public_dns}"
}
