resource "aws_vpc" "dataeng_pricing" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "subneta" {
  vpc_id     = "${aws_vpc.dataeng_pricing.id}"
  availability_zone = "${var.az1}"
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "subnetb" {
  vpc_id     = "${aws_vpc.dataeng_pricing.id}"
  availability_zone = "${var.az2}"
  cidr_block = "10.0.0.0/24"
}

resource "aws_internet_gateway" "igw" {
  vpc_id     = "${aws_vpc.dataeng_pricing.id}"
}

resource "aws_route_table" "rtl" {
  vpc_id = "${aws_vpc.dataeng_pricing.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_route_table_association" "suba_rt" {
  route_table_id = "${aws_route_table.rtl.id}"
  subnet_id = "${aws_subnet.subneta.id}"
}

resource "aws_route_table_association" "subb_rt" {
  route_table_id = "${aws_route_table.rtl.id}"
  subnet_id = "${aws_subnet.subnetb.id}"
}

resource "aws_security_group" "vpc_internal_access" {
  name = "vpc_internal_access"
  vpc_id     = "${aws_vpc.dataeng_pricing.id}"
  ingress {
    self = true
    from_port = 0
    to_port = 0
    protocol = -1 
    cidr_blocks = ["${var.myip}/32"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    self = true
  }
}

resource "aws_security_group" "public_access" {
  name = "public_access"
  vpc_id     = "${aws_vpc.dataeng_pricing.id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.myip}/32"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.dataeng_pricing.id}"
  service_name = "com.amazonaws.${var.region}.s3"
  route_table_ids = ["${aws_route_table.rtl.id}"]
}

