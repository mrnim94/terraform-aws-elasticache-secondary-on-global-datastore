# Define Local Values in Terraform
locals {
  owners = var.business_divsion
  environment = var.environment
  name = "redis-${var.business_divsion}-${var.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
  redis_cluster_name = "${local.name}-secondary"
} 