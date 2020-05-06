provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
}

module "vpc"{
  source = "./vpc"
  vpc_cidr=  var.vpc_cidr
  public_cidr = var.public_cidr
  private_cidr = var.private_cidr
 
}
module "ec2"{
 source = "./ec2"
 subnet_id = module.vpc.public_subnet_out
}
