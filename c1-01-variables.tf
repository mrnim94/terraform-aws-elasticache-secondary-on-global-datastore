# Input Variables - Placeholder file
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-2"  
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}
# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "SAP"
}

//checked
variable "family" {
  type = string
  default = "redis5.0"
  description = "(Required) The family of the ElastiCache parameter group."
}

variable "global_replication_group_id" {
  description = "(Required) The ID of the global replication group to which this replication group should belong"
  type = string
  default = "" 
}

variable "automatic_failover_enabled" {
  default = true
  description = "- (Optional) Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If enabled, num_cache_clusters must be greater than 1. Must be enabled for Redis (cluster mode enabled) replication groups."
}

variable "multi_az_enabled" {
  default = true
  description = "- (Optional) Specifies whether to enable Multi-AZ Support for the replication group. If true, automatic_failover_enabled must also be enabled. Defaults to true."
}

//checked
variable "num_nodes" {
  default = "3"
  description = "- (Optional) Number nodes of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Conflicts with num_node_groups, the deprecatednumber_cache_clusters, or the deprecated cluster_mode."
}

variable "create_elasticache_subnet_group" {
  type = bool
  default = false
  description = "- (Optional) The ID of the VPC is to create Security Group."
}

variable "maintenance_window" {
  default = "sun:02:30-sun:03:30"
  description = "– (Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00."
}

variable "private_subnets" {
  type = list
  description = "- (Optional) A list of private subnets inside the VPC."
  default = []
}

variable "elasticache_subnet_group_name" {
  type = string
  default = "Unknown"
  description = "- (Optional) Name of the cache subnet group to be used for the replication group."
}

variable "vpc_id" {
  type = string
  default = "Unknown"
  description = "- (Required) The ID of the VPC is to create Security Group."
}