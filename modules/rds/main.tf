# Create subnets in each availability zone for RDS, each with address blocks within the VPC.
resource "aws_subnet" "rds" {
  count      = length(var.azs) > 0 ? length(var.azs) : 0
  vpc_id     = var.vpc_id
  cidr_block = cidrsubnet("10.0.0.0/24", 8, 10 + count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "rds-${element(var.azs, count.index)}"
  }
}


# Create a subnet group with all of our RDS subnets. The group will be applied to the database instance.
resource "aws_db_subnet_group" "default" {
  name        = "${var.rds-identifier}-subnet-group"
  description = "Terraform example RDS subnet group"
  subnet_ids  = aws_subnet.rds.*.id
}

# Create a RDS security group in the VPC which our database will belong to.
resource "aws_security_group" "rds" {
  name        = "terraform_rds_security_group"
  description = "Terraform example RDS MySQL server"
  vpc_id      = var.vpc_id

  # Keep the instance private by only allowing traffic from the web server.
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups =  var.security_groups
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-rds-security-group"
  }
}

resource "aws_db_instance" "default" {

  identifier                = var.rds-identifier
  allocated_storage         = var.storage
  engine                    = var.engine
  engine_version            = lookup(var.engine_version, var.engine)
  instance_class            = var.instance_class
  name                      = var.db_name
  username                  = var.username
  password                  = var.password
  db_subnet_group_name      = aws_db_subnet_group.default.id
  vpc_security_group_ids    = aws_security_group.rds.*.id
  skip_final_snapshot       = true
  final_snapshot_identifier = "Ignore"
}
