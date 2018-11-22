resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = "${file(var.pub_key)}"
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic*"]
  }
}

data "aws_security_group" "default" {
  name = "default"
}

resource "aws_instance" "main" {
  key_name      = "${aws_key_pair.ssh_key.key_name}"
  ami           = "${data.aws_ami.ami.id}"
  instance_type = "${var.instance_type}"
}

resource "aws_security_group_rule" "allow_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["${var.your_ip}"]

  security_group_id = "${data.aws_security_group.default.id}"
}
