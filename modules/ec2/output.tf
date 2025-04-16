output "instance_id" {
  description = "The ID of the created EC2 instance"
  value       = aws_instance.ec2_instance.id
}


output "private_ip" {
  description = "The private IP of the created EC2 instance"
  value       = aws_instance.ec2_instance.private_ip
}
output "instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}