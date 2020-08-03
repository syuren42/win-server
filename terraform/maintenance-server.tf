
resource "aws_instance" "maintenance-server" {
  ami                  = var.instance_ami
  instance_type        = "t3.medium"
  key_name             = aws_key_pair.ssh-key.key_name
  subnet_id            = aws_subnet.public_a.id
  iam_instance_profile = aws_iam_instance_profile.systems_manager.name
  user_data            = file("./userdata_maintenance.sh")
  tags = {
    Name = "Maintenance_Server"
  }

}

# ElasticIP
resource "aws_eip" "maintenance-server-eip" {
  instance = "${aws_instance.maintenance-server.id}"
  vpc      = true
}




