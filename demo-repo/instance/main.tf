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

  # use local.ami_id to obtain the ami via the order of precedence below.
  # 1. var.ami_id - set ami_id to non-empty value to use this.
  # 2. hcp packer image - use machine image identified from hcp packer registry.
  # 3. aws_ami - use ami obtained from aws_ami.ubuntu data source.
  ami_id = var.ami_id != "" ? var.ami_id : (data.hcp_packer_artifact.image.external_identifier != "" ? data.hcp_packer_artifact.image.external_identifier : data.aws_ami.ubuntu.id)
}

data "terraform_remote_state" "common" {
  backend = "remote"

  config = {
    organization = var.tfe_organization
    workspaces = {
      name = var.workspace_common
    }
  }
}

resource "aws_security_group" "sg_ingress" {
  name        = "${var.prefix}_ingress_sg-${var.environment}"
  description = "${var.prefix} Ingress Security Group"
  vpc_id      = data.terraform_remote_state.common.outputs.vpc_id

  # trusted cidr blocks
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.trusted_cidr_blocks
  }

  # vpc cidr block
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.terraform_remote_state.common.outputs.vpc_cidr_block]
  }

  tags = {
    Name = "${var.prefix}_ingress_sg-${var.environment}"
  }
}

resource "aws_security_group" "sg_egress" {
  name        = "${var.prefix}_egress_sg-${var.environment}"
  description = "${var.prefix} Egress Security Group"
  vpc_id      = data.terraform_remote_state.common.outputs.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}_egress_sg-${var.environment}"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# HCP Packer Image
data "hcp_packer_artifact" "image" {
  bucket_name  = var.hcp_packer_image_bucket_name
  channel_name = var.hcp_packer_image_channel
  platform     = "aws"
  region       = var.region
}

resource "aws_instance" "app" {
  subnet_id                   = element(data.terraform_remote_state.common.outputs.public_subnets, 1)
  associate_public_ip_address = true
  vpc_security_group_ids = concat(
    [
      aws_security_group.sg_ingress.id,
      aws_security_group.sg_egress.id
    ],
    var.instance_security_group_ids
  )

  amii = "ami-0f46ba7b0d66af83b" # a revoked image
  # ami = data.aws_ami.ubuntu.id
  # ami = data.hcp_packer_artifact.image.external_identifier # hcp packer image
  # ami = local.ami_id

  instance_type = var.instance_type

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
  }

  tags = merge(
    { Name = "${var.prefix}-app-${var.environment}" },
    local.tags
  )
}

