locals {
  availability_zones = [ for a in data.aws_availability_zones.available.names: a if try(regex("^[a-z]{2}-[a-z]+-[0-9][a-z]$", a), false) != false ]
  public_subnets  = flatten([ for k, v in var.subnet_cidr_blocks : [ for c in v : join("-", [k, c]) ] if k == "public" ])
  private_subnets = flatten([ for k, v in var.subnet_cidr_blocks : [ for c in v : join("-", [k, c]) ] if k == "private" ])
}

module "vpc" {
  source     = "./modules/vpc"

  cidr_block = var.vpc_cidr_block

  tags = var.tags
}

module "elastic_ip" {
  source = "./modules/elastic_ip"

  tags = var.tags
}

module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id = module.vpc.id

  tags = var.tags
}

module "nat_gateway" {
  source = "./modules/nat_gateway"

  allocation_id = module.elastic_ip.id
  subnet_id = module.subnet.ids[1]

  tags = var.tags
}

module "route_table" {
  source              = "./modules/route_table"

  vpc_id              = module.vpc.id
  route_tables        = toset([for k, v in var.subnet_cidr_blocks : k])
  internet_gateway_id = module.internet_gateway.id
  nat_gateway_id      = module.nat_gateway.id

  tags = var.tags
}

module "subnet" {
  source             = "./modules/subnet"

  vpc_id             = module.vpc.id
  subnet_cidr_blocks = concat(local.public_subnets, local.private_subnets)
  availability_zone  = var.availability_zone
  route_table_ids    = module.route_table.ids

  tags = var.tags
}

module "rds" {
  source         = "./modules/rds"

  identifier     = var.rds_identifier

  availability_zone  = var.availability_zone

  engine         = var.rds_engine
  engine_version = var.rds_engine_version

  instance_class = var.rds_instance_class

  username       = var.rds_username
  password       = var.rds_password

  tags = var.tags
}

module "ec2" {
  source        = "./modules/ec2"

  availability_zone  = var.availability_zone

  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  subnet_id     = module.subnet.ids[0]

  tags = var.tags
}