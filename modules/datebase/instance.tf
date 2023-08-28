# MySQL Instance 생성
resource "aws_db_instance" "this" {
  count                        = length(var.rds_az)
  
  identifier                   = format("${var.tags.Environment}-rdsinst-%s-${element(split("-", var.rds_az[count.index]), 1)}", var.rds_value[element(split("-", var.rds_az[count.index]), 0)].cluster_identifier)
  instance_class               = var.rds_value[element(split("-", var.rds_az[count.index]), 0)].instance_class
  engine                       = lookup(var.rds_value[element(split("-", var.rds_az[count.index]), 0)], "engine", "mysql")
  engine_version               = lookup(var.rds_value[element(split("-", var.rds_az[count.index]), 0)], "engine_version", "5.7")
  availability_zone            = "${var.region}${substr(element(split("-", var.rds_az[count.index]), 1), -1, -1)}"
  performance_insights_enabled = true
  apply_immediately            = var.rds_value[element(split("-", var.rds_az[count.index]), 0)].apply_immediately
  auto_minor_version_upgrade   = false
  monitoring_role_arn          = lookup(var.rds_value[element(split("-", var.rds_az[count.index]), 0)], "monitoring_role_arn", null)
  monitoring_interval          = lookup(var.rds_value[element(split("-", var.rds_az[count.index]), 0)], "monitoring_interval", null)

  tags = merge(
    {
      Name    = format("${var.tags.Environment}-rdsinst-%s-${element(split("-", var.rds_az[count.index]), 1)}", var.rds_value[element(split("-", var.rds_az[count.index]), 0)].cluster_identifier)
      Type    = "rdsinst"
      Purpose = "postgres"
    },
    var.tags
  )
}