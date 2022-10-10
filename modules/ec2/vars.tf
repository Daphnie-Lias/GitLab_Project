variable "name" {}
variable "test_profile" {}
variable "account" {}
variable "private_subnet_ids" {}
variable "public_subnet_ids" {}
variable "alb_target_group_arn" {
  type = list(string)
}
variable "security_group" {}
variable "region" {
  default = "eu-east-1"
}
variable "amis" {
  type = map(string)
}
variable "instance_type" {
  description = "EC2 instance type to use for the argo EC2 instances."
  default     = "t2.micro"
}

variable "autoscaling_group_min_size" {}
variable "autoscaling_group_max_size" {}


