resource "aws_security_group" "allow-sgs-setup" {
  name   = "allow-sgs-setup"
  vpc_id = aws_vpc.this.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [local.allowed-cidr]
  }

  tags = {
    Name = "allow-storage-gateway-setup-https"
  }

  description = "allow-storage-gateway-setup-https"

}



locals {
  storage_gateway_sg_name = "example-storage-gateway"
}

resource "aws_security_group" "deployment-bastion" {
  name   = "devops-production-deployment-bastion"
  vpc_id = aws_vpc.this.id
}

resource "aws_security_group_rule" "ingress_80" {
  description              = "For activation"
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 80
  type                     = "ingress"
  source_security_group_id = aws_security_group.deployment-bastion.id
}

resource "aws_security_group_rule" "egress_all" {
  description       = "egress"
  from_port         = 0
  protocol          = "ALL"
  security_group_id = "${aws_security_group.storage_gateway.id}"
  to_port           = 65535
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "storage_gateway" {
  name        = "${local.storage_gateway_sg_name}"
  description = "Allow inbound NFS and HTTP traffic"
  vpc_id      = aws_vpc.this.id

  tags = {
    "Name" = "${local.storage_gateway_sg_name}"
  }
}

resource "aws_security_group" "management_storage_gateway_access" {
  name        = "${local.storage_gateway_sg_name}-access-management"
  description = "Attach this group to your instances to get access to the storage gateway via NFS."
  vpc_id      = aws_vpc.this.id

  tags = {
    "Name" = "${local.storage_gateway_sg_name}-access"
  }
}

resource "aws_security_group" "product_storage_gateway_access" {
  name        = "${local.storage_gateway_sg_name}-access-production"
  description = "Attach this group to your instances to get access to the storage gateway via NFS."
  vpc_id      = aws_vpc.this.id

  tags = {
    "Name" = "${local.storage_gateway_sg_name}-access"
  }
}

resource "aws_security_group_rule" "ingress_2049_tcp" {
  description              = "For NFS"
  from_port                = 2049
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 2049
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.management_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_2049_udp" {
  description              = "For NFS"
  from_port                = 2049
  protocol                 = "udp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 2049
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.management_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_111_tcp" {
  description              = "For NFS"
  from_port                = 111
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 111
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.management_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_111_udp" {
  description              = "For NFS"
  from_port                = 111
  protocol                 = "udp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 111
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.management_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_20048_tcp" {
  description              = "For NFS"
  from_port                = 20048
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 20048
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.management_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_20048_udp" {
  description              = "For NFS"
  from_port                = 20048
  protocol                 = "udp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 20048
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.management_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_2049_tcp_product" {
  description              = "For NFS"
  from_port                = 2049
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 2049
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.product_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_2049_udp_product" {
  description              = "For NFS"
  from_port                = 2049
  protocol                 = "udp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 2049
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.product_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_111_tcp_product" {
  description              = "For NFS"
  from_port                = 111
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 111
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.product_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_111_udp_product" {
  description              = "For NFS"
  from_port                = 111
  protocol                 = "udp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 111
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.product_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_20048_tcp_product" {
  description              = "For NFS"
  from_port                = 20048
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 20048
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.product_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_20048_udp_product" {
  description              = "For NFS"
  from_port                = 20048
  protocol                 = "udp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 20048
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.product_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_139_tcp_product" {
  description              = "For SMBv2"
  from_port                = 139
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 139
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.product_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_139_udp_product" {
  description              = "For SMBv2"
  from_port                = 139
  protocol                 = "udp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 139
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.product_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_445_tcp_product" {
  description              = "For SMBv3"
  from_port                = 445
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 445
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.product_storage_gateway_access.id}"
}

resource "aws_security_group_rule" "ingress_445_udp_product" {
  description              = "For SMBv3"
  from_port                = 445
  protocol                 = "udp"
  security_group_id        = "${aws_security_group.storage_gateway.id}"
  to_port                  = 445
  type                     = "ingress"
  source_security_group_id = "${aws_security_group.product_storage_gateway_access.id}"
}
