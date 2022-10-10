variable "allowed_cidr_blocks" {
  type    = list(string)
  default = ["99.99.99.0/24"]
}

variable "vpc_id" {}
variable "public_subnet_ids" {}