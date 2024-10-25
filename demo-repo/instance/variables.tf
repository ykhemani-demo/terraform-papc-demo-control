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

variable "tfe_organization" {
  type        = string
  description = "Name of (HCP) Terraform (Enterprise) organization."
}

variable "workspace_common" {
  type        = string
  description = "Name of workspace where common resources (e.g. VPC) have been provisioned."
}

variable "prefix" {
  type        = string
  description = "Naming prefix"
}

variable "region" {
  type        = string
  description = "AWS Region in which to deploy our resources."
  default     = "us-east-2"
}

variable "environment" {
  description = "This environment for this stack"
  default     = "demo"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC."
  default     = "10.0.0.0/16"
}

variable "trusted_cidr_blocks" {
  type        = list(string)
  description = "Trusted CIDR block to allow access from our subnets."
  default     = []
}

variable "instance_security_group_ids" {
  type        = list(string)
  description = "List of additional security group ID's to apply to the instance."
  default     = []
}

variable "instance_type" {
  description = "Specifies the AWS instance type."
  default     = "t2.micro"
}

variable "root_volume_type" {
  type        = string
  description = "Root volume type."
  default     = "gp2"
}

variable "root_volume_size" {
  type        = number
  description = "Root volume size in GB."
  default     = 50
}

variable "hcp_packer_image_bucket_name" {
  type        = string
  description = "The slug of the HCP Packer Registry image bucket to pull from."
  default     = ""
}

variable "hcp_packer_image_channel" {
  type        = string
  description = "The channel that points to the version of the image you want."
  default     = ""
}

variable "ami_id" {
  type        = string
  description = "The ID of Amazon Machine Image (AMI) to use for AWS instance."
  default     = ""
}