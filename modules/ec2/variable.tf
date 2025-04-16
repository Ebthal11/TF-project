variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of Security Group IDs for the instance"
  type        = list(string)
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the instance"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
}

variable "ssh_user" {
  description = "SSH username for the instance (e.g., ubuntu)"
  type        = string
  default     = "ubuntu"
}

variable "private_key_path" {
  description = "Path to the private key file used for SSH"
  type        = string
}
variable "dependency_module" {
  description = "Module or resources this EC2 instance depends on"
  type        = any
}
variable "bastion_public_ip" {
  description = "Public IP of the Bastion Host for accessing private instances"
  type        = string
  default     = ""
}
