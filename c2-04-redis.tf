#https://medium.com/swlh/terraform-how-to-use-conditionals-for-dynamic-resources-creation-6a191e041857
resource "aws_elasticache_subnet_group" "redis" {
  count = var.create_elasticache_subnet_group ? 1 : 0
  name       = "subnet-group-redis"
  subnet_ids = var.private_subnets
}



resource "aws_elasticache_replication_group" "redis_secondary" {

  replication_group_id          = lower(local.redis_cluster_name)
  description = lower(local.redis_cluster_name)
  global_replication_group_id   = var.global_replication_group_id

  automatic_failover_enabled    = var.automatic_failover_enabled
  multi_az_enabled              = var.multi_az_enabled

  num_cache_clusters         = var.num_nodes
  subnet_group_name             = "${var.create_elasticache_subnet_group ? aws_elasticache_subnet_group.redis[0].name : var.elasticache_subnet_group_name}"
  security_group_ids            = [aws_security_group.redis.id]
  maintenance_window            = var.maintenance_window
  port                          = "6379"

  tags = merge(
    local.common_tags,
    tomap({
      "Name"    = "CacheReplicationGroup"
    })
  )
  
  lifecycle {
    ignore_changes = [engine_version]
  }
}