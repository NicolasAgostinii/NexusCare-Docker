data "aws_vpc" "nexus_vpc" {
  id = "vpc-0baab92eeab9e7971"  # ID da sua VPC
}
module "vpc" {
    source = "./modules/vpc"
    project_name = var.project_name
}

module "backend" {
    source = "./modules/backend"
    vpc_id = data.aws_vpc.nexus_vpc.id
   sn_pub01 = module.vpc.sn_pub01
 
}

module "database" {
    source = "./modules/database"
    vpc_id = data.aws_vpc.nexus_vpc.id
    sn_pub01 = module.vpc.sn_pub01
}

module "frontend" {
    source = "./modules/frontend"
    vpc_id = data.aws_vpc.nexus_vpc.id
    sn_pub01 = module.vpc.sn_pub01
}
