/* Variables for RDS Postgres */
variable "rds-identifier" {
  default     = "rds-postgres"
  description = "Identifier for your DB"
}

variable "storage" {
  default     = "10"
  description = "Storage size in GB"
}

variable "engine" {
  default     = "postgres"
  description = "Engine type, example values mysql, postgres"
}

variable "engine_version" {
  description = "Engine version"

  default = {
    postgres = "13.7"
  }
}

variable "instance_class" {
  default     = "db.t2.micro"
  description = "Instance class"
}

variable "db_name" {
  default     = "mydb"
  description = "db name"
}

variable "username" {
  default     = "myuser"
  description = "User name"
}

variable "password" {
  description = "password, provide through your ENV variables"
  default     = "myuser"
}

variable "vpc_id" {}
variable "azs" {}
variable "security_groups" {}