resource "aws_directory_service_directory" "bar" {
  name     = "corp.syuren42example.com"
  password = "jJ$$DOEJF6%3abas"
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
