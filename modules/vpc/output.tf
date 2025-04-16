output "public_subnet_1_id" {
  value = aws_subnet.public1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private2.id
}
output "vpc_id" {
  value = aws_vpc.ebtehal-vpc.id
}

output "public_sg_id" {
  value = aws_security_group.public_sg.id
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}

output "public_lb_sg_id" {
  value = aws_security_group.public_lb_sg.id
}

output "private_lb_sg_id" {
  value = aws_security_group.private_lb_sg.id
}