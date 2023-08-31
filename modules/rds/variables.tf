variable "identifier" {
  description = "The identifier of the RDS"
  type        = string
}

variable "availability_zone" {}

variable "engine" {
	description = "The Engine of the RDS"
  type        = string
}

variable "engine_version" {
	description = "The Engine version of the RDS"
  type        = string
}

variable "instance_class" {
	description = "The RDS Instance class"
  type        = string
	default			= "db.t2.micro"
}

variable "vpc_security_group_ids" {}

variable "allocated_storage" {
	description = "The RDS Instance class"
  type        = number
	default			= 20
}

variable "username" {
	description = "The RDS username"
  type        = string
}

variable "password" {
	description = "The RDS password"
  type        = string
}

variable "multi_az" {
	description = "The RDS Multi AZ"
  type        = bool
	default     = false
}

variable "backup_retention_period" {
	description = "The RDS Backup retention period"
  type        = number
	default     = 0
}

variable "skip_final_snapshot" {
	description = "The RDS Skip final snapshot"
  type        = bool
	default     = true
}

variable "apply_immediately" {
	description = "The RDS Apply immediately"
  type        = bool
	default     = true
}

variable "deletion_protection" {
	description = "The RDS Deletion protection"
  type        = bool
	default     = false
}

variable "subnet_ids" {}

variable "tags" {}