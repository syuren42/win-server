
resource "aws_instance" "maintenance-server" {
  ami                    = var.AMAZONLINUX2_AMIS[var.region]
  instance_type          = "t3.small"
  key_name               = aws_key_pair.mykey.key_name
#  vpc_security_group_ids = ["${aws_security_group.allow-rdp.id}"]
  subnet_id               = aws_subnet.public_a.id
  iam_instance_profile = aws_iam_instance_profile.systems_manager.name
  tags = {
    Name = "Maintenance_Server"
  }

}

# ElasticIP
resource "aws_eip" "maintenance-server-eip" {
    instance = "${aws_instance.maintenance-server.id}"
    vpc = true
}




