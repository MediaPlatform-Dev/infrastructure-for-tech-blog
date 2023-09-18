locals {
  availability_zones = [ for a in data.aws_availability_zones.available.names: a if try(regex("^[a-z]{2}-[a-z]+-[0-9][a-z]$", a), false) != false ]
  public_subnets  = flatten([ for k, v in var.subnet_cidr_blocks : [ for c in v : join("-", [k, c]) ] if k == "public" ])
  private_subnets = flatten([ for k, v in var.subnet_cidr_blocks : [ for c in v : join("-", [k, c]) ] if k == "private" ])
  tags = merge(
    {
      Created = "${timestamp()}"
    },
    var.tags
  )
}

module "dynamodb" {
  source = "./modules/dynamodb"

  name = var.dynamodb_name

  billing_mode = var.dynamodb_billing_mode
  read_capacity = var.dynamodb_read_capacity
  write_capacity = var.dynamodb_write_capacity

  hash_key = var.dynamodb_hash_key

  tags = local.tags
}

module "s3" {
  source = "./modules/s3"

  bucket = var.s3_bucket

  tags = local.tags
}

module "vpc" {
  source     = "./modules/vpc"

  cidr_block = var.vpc_cidr_block

  tags = local.tags
}

module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id = module.vpc.id

  tags = local.tags
}

module "security_group" {
  source = "./modules/security_group"
  
  vpc_id = module.vpc.id

  for_each = toset(keys(var.security_group_rules))

  resource_name = each.value
  security_group_rules = var.security_group_rules[each.value]

  tags = local.tags
}

module "subnet" {
  source             = "./modules/subnet"

  vpc_id             = module.vpc.id

  for_each = toset(keys(var.subnet_cidr_blocks))

  visibility = each.value
  subnet_cidr_blocks = var.subnet_cidr_blocks[each.value]
  availability_zone  = local.availability_zones

  tags = local.tags
}

module "elastic_ip" {
  source = "./modules/elastic_ip"

  tags = local.tags
}

module "nat_gateway" {
  source = "./modules/nat_gateway"

  allocation_id = module.elastic_ip.id
  subnet_id = module.subnet["public"].ids[0]

  tags = local.tags
}

module "route_table" {
  source              = "./modules/route_table"

  vpc_id              = module.vpc.id
  internet_gateway_id = module.internet_gateway.id
  nat_gateway_id      = module.nat_gateway.id

  for_each = toset(keys(var.subnet_cidr_blocks))
  visibility = each.value
  subnet_cidr_blocks = var.subnet_cidr_blocks[each.value]
  subnet_ids = module.subnet[each.value].ids

  tags = local.tags
}

module "ec2" {
  source        = "./modules/ec2"

  availability_zone  = local.availability_zones[0]

  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  subnet_id     = module.subnet["public"].ids[3]
  vpc_security_group_ids = [module.security_group["ec2"].id]

  key_name = var.ec2_key_name

  tags = local.tags
}

module "rds" {
  source         = "./modules/rds"

  identifier     = local.tags.Project

  availability_zone  = local.availability_zones[0]

  engine         = var.rds_engine
  engine_version = var.rds_engine_version

  instance_class = var.rds_instance_class
  subnet_ids     = module.subnet["private"].ids
  vpc_security_group_ids = [module.security_group["rds"].id]

  db_name         = var.rds_db_name
  username       = var.rds_username
  password       = var.rds_password

  tags = local.tags
}

resource "null_resource" "wordpress" {
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type        = "ssh"
    host        = module.ec2.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("${var.ec2_key_name}.pem")
  }

  ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "${var.ec2_key_name}.pem"
    destination = "/tmp/terraform-key.pem"
  }

  ## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  ## Install docker, start and enable the service, pull wordpress image and create the container
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/tf-deploy.pem",
      "sudo yum update -y",
      "sudo yum install docker -y",
      "sudo systemctl restart docker && sudo systemctl enable docker",
      "sudo docker pull wordpress",
      "sudo docker run --name wordpress -p 80:80 -e WORDPRESS_DB_HOST=${module.rds.endpoint} -e WORDPRESS_DB_USER=${var.rds_username} -e WORDPRESS_DB_PASSWORD=${var.rds_password} -e WORDPRESS_DB_NAME=${var.rds_db_name} -d wordpress"
    ]
  }
}