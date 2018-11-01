data "aws_ami" "amzn2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bastion-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["${var.rescale_account_for_public_ami}"] # amz
}

resource "aws_key_pair" "bastion_key" {
  key_name = "${var.ssh_key_name}"
  public_key = "${var.public_key_content}"
}

resource "aws_instance" "bastion" {
  ami           = "${data.aws_ami.amzn2.id}"
  instance_type = "t2.nano"
  key_name = "${aws_key_pair.bastion_key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.public_access.id}",
                            "${aws_security_group.vpc_internal_access.id}"]
  subnet_id = "${aws_subnet.subneta.id}"
  associate_public_ip_address = true
  tags {
    Name = "bastion-host"
  }
}
