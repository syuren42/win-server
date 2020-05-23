variable "access_key" {}
variable "secret_key" {}
variable "region" {}

variable "WIN_AMIS" {
  type = map
  default = {
    ap-northeast-1 = "ami-0f1b16857e17905cb"
  }
}



variable "AMAZONLINUX2_AMIS" {
  type = map
  default = {
    ap-northeast-1 = "ami-0f310fced6141e627"
  }
}


variable "PATH_TO_PRIVATE_KEY" { default = "mykey" }
variable "PATH_TO_PUBLIC_KEY" { default = "mykey.pub" }
variable "INSTANCE_USERNAME" { default = "syuren42admin" }
variable "INSTANCE_PASSWORD" {}
variable "ADDC_PASSWORD" {}
variable "AD_DOMAIN_NAME" {}




