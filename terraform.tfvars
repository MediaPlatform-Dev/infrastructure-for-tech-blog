# General
region = "ap-northeast-2"

tags = {
  Project = "tech-blog"
}


# VPC
vpc_cidr_block     = "10.0.0.0/16"


# Security Group
security_group_rules = {
  ec2 = [
    {
      type = "ingress"
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type = "ingress"
      from_port = 80
      to_port = 80
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type = "ingress"
      from_port = 443
      to_port = 443
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type = "egress"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  rds = [
    {
      type = "ingress"
      from_port = 3306
      to_port = 3306
      protocol = "TCP"
      cidr_blocks = ["10.0.0.0/16"]
    },
    {
      type = "egress"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}


# Subnet
subnet_cidr_blocks  = {
  public  = [
    "10.0.0.0/24",
    "10.0.64.0/24",
    "10.0.128.0/24",
    "10.0.192.0/24"
  ]
  private = [
    "10.0.32.0/24",
    "10.0.96.0/24",
    "10.0.160.0/24",
    "10.0.224.0/24"
  ]
}


# RDS
rds_engine = "mariadb"
rds_engine_version = "10.6"
rds_instance_class = "db.t3.micro"
rds_db_name = "wordpress"
rds_username = "root"
rds_password = "rootroot"


# EC2
ec2_ami = "ami-04a7c24c015ef1e4c"
ec2_instance_type = "t3.micro"
ec2_key_name = "mzd_TechBlog_dev"