
# General VPC and Subnets

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for the public LB"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs for the private LB"
  type        = list(string)
}


# LB Names and Security Groups

variable "public_lb_name" {
  description = "Name of the public ALB"
  type        = string
  default     = "public-alb"
}

variable "private_lb_name" {
  description = "Name of the private ALB"
  type        = string
  default     = "private-alb"
}

variable "public_lb_sg" {
  description = "Security Group ID for the public LB"
  type        = string
}

variable "private_lb_sg" {
  description = "Security Group ID for the private LB"
  type        = string
}


# Target Group Names

variable "public_tg_name" {
  description = "Name of the public Target Group"
  type        = string
  default     = "public-tg"
}

variable "private_tg_name" {
  description = "Name of the private Target Group"
  type        = string
  default     = "private-tg"
}


# Instances to Attach

variable "public_target_instance_ids" {
  description = "List of instance IDs for the public LB target group"
  type        = list(string)
  default     = []
}

variable "private_target_instance_ids" {
  description = "List of instance IDs for the private LB target group"
  type        = list(string)
  default     = []
}


# For HTTPS

variable "certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS"
  type        = string
  default     = ""
}