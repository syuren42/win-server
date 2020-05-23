

data "template_file" "userdata_win" {
  template = <<EOF
<script>
echo "" > _INIT_STARTED_
net user ${var.INSTANCE_USERNAME} /add /y
net user ${var.INSTANCE_USERNAME} ${var.INSTANCE_PASSWORD}
net localgroup administrators ${var.INSTANCE_USERNAME} /add
echo "" > _INIT_COMPLETE_
</script>
<persist>false</persist>
EOF
}

resource "aws_instance" "win-server" {
  ami                    = var.WIN_AMIS[var.region]
  instance_type          = "t3.large"
  key_name               = aws_key_pair.mykey.key_name
  user_data              = data.template_file.userdata_win.rendered
  vpc_security_group_ids = ["${aws_security_group.allow-rdp.id}"]
  subnet_id               = aws_subnet.public_a.id
  iam_instance_profile = aws_iam_instance_profile.systems_manager.name
  tags = {
    Name = "Windows_Server"
  }

}

# ElasticIP
resource "aws_eip" "win-sever-ip" {
    instance = "${aws_instance.win-server.id}"
    vpc = true
}


output "ip" {

  value = "${aws_instance.win-server.public_ip}"

}


