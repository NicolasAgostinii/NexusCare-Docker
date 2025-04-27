resource "aws_vpc" "sidral_vpc" {
  cidr_block = "172.102.0.0/16"
  tags = {
    Name = "sidral-vpc"
  }
}
module "vpc" {
    source = "./modules/vpc"
    project_name = var.project_name
}
module "loadbalancer" {
    source = "./modules/loadbalancer"
    vpc_id = aws_vpc.vpc_sidral.id
    sn_pub01 = module.vpc.sn_pub01

}

module "backend" {
    source = "./modules/backend"
    vpc_id = aws_vpc.vpc_sidral.id
   sn_pub01 = module.vpc.sn_pub01
 
}

module "database" {
    source = "./modules/database"
    vpc_id = aws_vpc.vpc_sidral.id
    sn_pub01 = module.vpc.sn_pub01
}

module "frontend" {
    source = "./modules/frontend"
    vpc_id = aws_vpc.vpc_sidral.id
    sn_pub01 = module.vpc.sn_pub01
}
