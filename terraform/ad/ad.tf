resource "aws_directory_service_directory" "bar" {
  name     = var.AD_DOMAIN_NAME
  password = var.ADDC_PASSWORD
  edition  = "Standard"
  type     = "MicrosoftAD"

  vpc_settings {
    vpc_id     =  aws_vpc.this.id
    subnet_ids = [ aws_subnet.public_a.id, aws_subnet.public_c.id]
  }

  tags = {
    Project = "virtual-office"
  }
}
