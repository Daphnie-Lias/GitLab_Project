
variable "cidr_block" {
  default = "10.0.0.0/24"
}

variable "subnet" {
  default = "10.0.0.0/24"
}

variable "allowed_cidr_blocks" {
  type    = list(string)
  default = ["99.99.99.0/24"]
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "INSTANCE_USERNAME" {
  default = "admin" # username which will be used while doing remote-execution with the launched instance.
}

variable "acl_value" {
  default = "private"
}

/* Provider variables */
variable "aws_access_key" {
  type        = string
  description = "AWS access key"

}
variable "aws_secret_key" {
  type        = string
  description = "AWS secret key"

}
variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}



