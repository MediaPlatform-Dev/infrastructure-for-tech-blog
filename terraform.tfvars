# General
region = "ap-northeast-2"
availability_zone = "a"


# VPC
vpc_cidr_block     = "10.0.0.0/16"

# Subnet
subnet_cidr_blocks  = {
  public = ["10.0.0.0/24"]
  private = ["10.0.128.0/24"]
}

# Security Group
security_groups = {
  "ec2" = {
    "ingress" = 
    "egress" = 
  }
  "rds" = {
    "ingress" = 
    "egress" = 
  }
}

# RDS
rds_identifier = "wordpress"
rds_engine = "mariadb"
rds_engine_version = "10.6"
rds_instance_class = "db.t3.micro"
rds_username = "root"
rds_password = "rootroot"

# EC2
ec2_ami = "ami-04a7c24c015ef1e4c"
ec2_instance_type = "t3.micro"

tags = {
  Project = "tech-blog"
}