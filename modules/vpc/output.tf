output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "public_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "security_group" {
  value = aws_security_group.ec2_sg.*.id
}