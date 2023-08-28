# General
region = "ap-northeast-2"
availability_zones = [ "az2a", "az2b" ]
project = "tech-blog"


# VPC
vpc_cidr     = "10.0.0.0/16"
subnet_cidr  = {
  public = [
    "10.0.0.0/24"
  ]
  private = [
    "10.0.128.0/24"
  ]
}


# RDS
rds_config = {
  "rds" = {
    engine              = "mysql"
    engine_version      = "5.7"
    instance_class      = "db.t2.micro"
    snapshot_identifier = null
    multi_az            = [ "az2a" ]
    apply_immediately   = true
    deletion_protection = false
  }
}

sg_rds_cidr = {
  # ingress
  "ingress_5432" = {
    type        = "ingress"
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
    description = "ingress all"
  },
  # egress
  "egress_5432" = {
    type        = "egress"
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
    description = "egress all"
  }
}

sg_rds_source = {

}