resource "aws_instance" "gateway" {
  ami           = "ami-07f05573dd3a8556f"
  instance_type = "m4.xlarge"

  # Refer to AWS File Gateway documentation for minimum system requirements.
  ebs_optimized = true
  subnet_id     = aws_subnet.public_a.id

  ebs_block_device {
    device_name           = "/dev/xvdf"
    volume_size           = "${var.ebs_cache_volume_size}"
    volume_type           = "gp2"
    delete_on_termination = true
  }

  key_name = aws_key_pair.ssh-key.key_name

  vpc_security_group_ids = [
    "${aws_security_group.storage_gateway.id}", aws_security_group.allow-sgs-setup.id
  ]

  volume_tags = {
    "Name" = "example-storage-gateway"
  }

  tags = {
    "Name" = "example-storage-gateway"
  }
}

variable "ebs_cache_volume_size" {
  description = "The size in GB of the EBS cache volume. (Optional) Default is 150 GB."
  default     = "150"
}

# ElasticIP
resource "aws_eip" "sgs-server-eip" {
  instance = "${aws_instance.gateway.id}"
  vpc      = true
}
