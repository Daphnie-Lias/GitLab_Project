variable "name" {
  default = "Terraform VPC"
}
variable "cidr_block" {
  default = "10.0.0.0/24"
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnet_tags" {
  default = {}
}

variable "private_subnet_tags" {
  default = {}
}

variable "account_owner" {
  default = ""
}

variable "alb_security_group" {}

variable "allowed_cidr_blocks" {
  type    = list(string)
  default = ["99.99.99.0/24"]
}