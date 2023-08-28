locals {
  public_subnets  = flatten([ for k, v in var.subnet_cidr : [ for i, c in v : join("-", [k, i, c]) ] if k == "public" ])
  private_subnets = flatten([ for k, v in var.subnet_cidr : [ for i, c in v : join("-", [k, i, c]) ] if k == "private" ])
}

module "network" {
  source             = "./modules/network"

  vpc_name           = "${var.project}-vpc"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones

  route_tables       = toset([for k, v in var.subnet_cidr : k])

  public_subnets     = local.public_subnets
  private_subnets    = local.private_subnets
  subnets            = concat(local.public_subnets, local.private_subnets)

  tags = {
    Project = var.project
  }
}

module "database" {
  source              = "./modules/database"

  region              = var.region
  vpc_id              = module.vpc.vpc_id

  rds_az              = flatten([ for k, v in var.rds_config : [ for az in lookup(var.rds_config[k], "multi_az") : join("-", [k, az]) ] ])
  rds_value           = var.rds_config
  sg_rds_cidr         = var.sg_rds_cidr
  sg_rds_source       = var.sg_rds_source

  rds_master_username = var.rds_master_username
  rds_master_password = var.rds_master_password

  subnet_ids          = module.vpc.private_subnet_ids

  tags = {
    Environment = var.environment
  }
}