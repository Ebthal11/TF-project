# Get latest Ubuntu 20.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical (official Ubuntu)
}

# EC2 instance with remote-exec provisioner
resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = "my-key"
  associate_public_ip_address = true  

  depends_on = [var.dependency_module]

  tags = {
    Name = var.instance_name
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 30",
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]

connection {
  type                = "ssh"
  user                = var.ssh_user
  private_key         = file(var.private_key_path)
  host                = var.bastion_public_ip != "" ? self.private_ip : self.public_ip
  timeout             = "2m"

  bastion_host        = var.bastion_public_ip != "" ? var.bastion_public_ip : null
  bastion_user        = var.ssh_user
  bastion_private_key = file(var.private_key_path)
}
  }
}
