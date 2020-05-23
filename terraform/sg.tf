resource "aws_security_group" "allow-rdp" {
  name = "allow-all"
  vpc_id = aws_vpc.this.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.1.1.0/24"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.1.1.0/24"]
  }

  tags = {
    Name = "allow-ssh-insubnet"
  }

  description = "virtual-office-rdp"

}