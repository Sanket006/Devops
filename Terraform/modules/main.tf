provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"

}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  
}

module "ec2" {
  source          = "./modules/ec2"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  ec2_sg_id       = module.sg.ec2_sg_id
}

module "alb" {
  source          = "./modules/alb"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  alb_sg_id       = module.sg.alb_sg_id
}

module "asg" {
  source        = "./modules/asg"
  alb_target_group_arn = module.alb.alb_target_group_arn
  launch_template_id   = module.ec2.launch_template_id
  public_subnets       = module.vpc.public_subnets
}

module "rds" {
  source = "./modules/rds"
  vpc_id = module.vpc.vpc_id
}

module "eks" {
  source = "./modules/eks"
}

