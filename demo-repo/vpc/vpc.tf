provider "aws" {
  region = var.region
  default_tags {
    tags = local.tags
  }
}

locals {
  tags = merge(
    var.global_tags,
    var.local_tags
  )

  private_subnets = [cidrsubnet(var.vpc_cidr, 8, 1)]
  public_subnets  = [cidrsubnet(var.vpc_cidr, 8, 101)]
}

variable "global_tags" {
  type        = map(string)
  description = "Default tags to apply to AWS resources. Meant to be defined via Variable Sets in your Terraform Cloud organization, but can be overriden if needed."
  default     = {}
}

variable "local_tags" {
  type        = map(string)
  description = "Local tags to apply to cloud resources."
  default     = {}
}

variable "prefix" {
  type        = string
  description = "Naming prefix"
  default     = "demo"
}

variable "region" {
  type        = string
  description = "AWS Region in which to deploy our resources."
  default     = "us-east-2"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC."
  default     = "10.0.0.0/16"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = "${var.prefix}-vpc"
  cidr = var.vpc_cidr

  azs                    = [data.aws_availability_zones.available.names[0]]
  private_subnets        = local.private_subnets
  public_subnets         = local.public_subnets
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = true
  enable_dns_hostnames   = true
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
