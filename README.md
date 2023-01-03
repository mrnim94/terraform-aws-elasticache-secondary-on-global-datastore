# terraform-aws-elasticache-secondary-on-global-store

## If you don't have a Global Datastore but have the existing Redis primary, You need to create a Global Datastore 

```hcl
resource "aws_elasticache_global_replication_group" "global_datastore" {
  provider = aws.redis-primary

  global_replication_group_id_suffix = "global-datastore-nim"
  primary_replication_group_id       = "redis-nimtechnology-dev"
}
```

## Next, Create the Redis secondary based on a Global Datastore that be created beforehand

```hcl
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-2"
}

provider "aws" {
  region = "us-east-1"
  alias = "redis-primary"
}

# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-on-aws-eks-nim"
    key    = "dev/vpc-redis-3/terraform.tfstate"
    region = "us-east-1" 
  }
}

module "elasticache-secondary-on-global-datastore" {
  source  = "mrnim94/elasticache-secondary-on-global-datastore/aws"
  version = "1.0.0"

  aws_region = var.aws_region
  business_divsion = "nimtechnology"
  elasticache_subnet_group_name = data.terraform_remote_state.vpc.outputs.elasticache_subnet_group_name
  environment = "dev"
  family = "redis5.0"
  global_replication_group_id = aws_elasticache_global_replication_group.global_datastore.id
  num_nodes = "2"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}
```

## In other to understand much more detail about the module. You should click below my post. 

[![Image](https://nimtechnology.com/wp-content/uploads/2023/01/image-1.png "[Redis] ElastiCache-Redis Cross-Region Replication|Global DataStore")](https://nimtechnology.com/2023/01/03/redis-elasticache-redis-cross-region-replicationglobal-datastore/)