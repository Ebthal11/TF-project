output "public_lb_arn" {
  description = "ARN of the public ALB"
  value       = aws_lb.public_lb.arn
}

output "public_lb_dns_name" {
  description = "DNS name of the public ALB"
  value       = aws_lb.public_lb.dns_name
}

output "private_lb_arn" {
  description = "ARN of the private ALB"
  value       = aws_lb.private_lb.arn
}

output "private_lb_dns_name" {
  description = "DNS name of the private ALB"
  value       = aws_lb.private_lb.dns_name
}

output "public_tg_arn" {
  description = "ARN of the public target group"
  value       = aws_lb_target_group.public_tg.arn
}

output "private_tg_arn" {
  description = "ARN of the private target group"
  value       = aws_lb_target_group.private_tg.arn
}