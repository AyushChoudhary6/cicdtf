module "vpc" {
  source = "./vpc"

#   vpc_name = "cicd-vpc"
  
}

module "ec2" {
  source = "./web"
  sn=module.vpc.pb_sn
  sg=module.vpc.sg_id
}