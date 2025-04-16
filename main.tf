# 1. Call the VPC Module
module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = "10.0.0.0/16"
  public_subnets_cidrs  = ["10.0.0.0/24", "10.0.2.0/24"]
  private_subnets_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]
  azs                   = ["us-east-1a", "us-east-1b"]
}

# 2. Call the EC2 Module for Public Instances (Proxies)
module "proxy_1" {
  source               = "./modules/ec2"
  instance_type        = "t2.micro"
  subnet_id            = module.vpc.public_subnet_1_id
  security_group_ids   = [module.vpc.public_sg_id]
  key_name             = "my-key"
  instance_name        = "proxy-1"
  ssh_user             = "ubuntu"
  private_key_path     = "~/.ssh/my-key.pem"
  depends_on           = [module.vpc]
  dependency_module    = module.vpc
}

module "proxy_2" {
  source               = "./modules/ec2"
  instance_type        = "t2.micro"
  subnet_id            = module.vpc.public_subnet_2_id
  security_group_ids   = [module.vpc.public_sg_id]
  key_name             = "my-key"
  instance_name        = "proxy-2"
  ssh_user             = "ubuntu"
  private_key_path     = "~/.ssh/my-key.pem"
  depends_on           = [module.vpc]
  dependency_module    = module.vpc
}

# 3. Call the EC2 Module for Private Instances (Backends)
module "backend_1" {
  source               = "./modules/ec2"
  instance_type        = "t2.micro"
  subnet_id            = module.vpc.private_subnet_1_id
  security_group_ids   = [module.vpc.private_sg_id]
  key_name             = "my-key"
  instance_name        = "backend-1"
  ssh_user             = "ubuntu"
  private_key_path     = "~/.ssh/my-key.pem"
  bastion_public_ip    = module.proxy_1.instance_public_ip  
  depends_on           = [module.vpc]
  dependency_module    = module.vpc
}


module "backend_2" {
  source               = "./modules/ec2"
  instance_type        = "t2.micro"
  subnet_id            = module.vpc.private_subnet_2_id
  security_group_ids   = [module.vpc.private_sg_id]
  key_name             = "my-key"
  instance_name        = "backend-2"
  ssh_user             = "ubuntu"
  private_key_path     = "~/.ssh/my-key.pem"
  bastion_public_ip    = module.proxy_1.instance_public_ip 
  depends_on           = [module.vpc]
  dependency_module    = module.vpc
}

# 4. Call the Load Balancer Module
module "loadbalancer" {
  source = "./modules/loadbalancer"

  vpc_id          = module.vpc.vpc_id
  public_subnets  = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  private_subnets = [module.vpc.private_subnet_1_id, module.vpc.private_subnet_2_id]

  public_lb_sg  = module.vpc.public_lb_sg_id
  private_lb_sg = module.vpc.private_lb_sg_id

  # LB and Target Group Names
  public_lb_name  = "public-alb"
  public_tg_name  = "public-tg"
  private_lb_name = "private-alb"
  private_tg_name = "private-tg"

  # Instance IDs for attaching to the Target Groups
  public_target_instance_ids  = [
    module.proxy_1.instance_id,
    module.proxy_2.instance_id
  ]

  private_target_instance_ids = [
    module.backend_1.instance_id,
    module.backend_2.instance_id
  ]
}

resource "null_resource" "write_ips" {
  depends_on = [
    module.proxy_1,
    module.proxy_2,
    module.backend_1,
    module.backend_2
  ]

  provisioner "local-exec" {
    command = <<EOT
echo "public-ip1   ${module.proxy_1.instance_public_ip}" > all-ips.txt
echo "public-ip2   ${module.proxy_2.instance_public_ip}" >> all-ips.txt
echo "private-ip1  ${module.backend_1.private_ip}" >> all-ips.txt
echo "private-ip2  ${module.backend_2.private_ip}" >> all-ips.txt
EOT
  }
}