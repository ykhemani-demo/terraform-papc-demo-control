terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.58"
    }

    github = {
      source  = "integrations/github"
      version = "~> 6.3"
    }
  }

  #  cloud {}

  required_version = "~> 1.9.0"
}

provider "github" {
  owner = var.vcs_owner

}

########################################################################

module "github-repo" {
  source = "./modules/terraform-github-repo"

  vcs_repo_name = var.vcs_repo_name
}

module "project" {
  source = "./modules/terraform-tfe-tfe_project"

  organization = var.tfe_organization
  project      = var.tfe_project
}

module "oauth_client" {
  source = "./modules/terraform-tfe-tfe_oauth_client"

  organization                 = var.tfe_organization
  github_personal_access_token = var.github_personal_access_token
}

resource "tfe_organization_run_task" "hcp" {
  organization = var.tfe_organization
  url          = var.run_task_hcp_url
  name         = "hcp"
  enabled      = true
  hmac_key     = var.run_task_hcp_hmac_key
}

resource "tfe_team" "team" {
  name                          = var.tfe_team
  organization                  = var.tfe_organization
  allow_member_token_management = false
  organization_access {
    manage_run_tasks = true
  }
}

resource "tfe_team_token" "team_token" {
  team_id = tfe_team.team.id
}

module "hcp_variable_set" {
  source  = "flowingis/variable-set/tfe"
  version = "0.3.1"

  name                            = "hcp"
  organization                    = var.tfe_organization
  environment_variables           = { "HCP_CLIENT_ID" = var.hcp_client_id }
  environment_sensitive_variables = { "HCP_CLIENT_SECRET" = var.hcp_client_secret }
}

resource "tfe_project_variable_set" "hcp" {
  project_id      = module.project.project_id
  variable_set_id = module.hcp_variable_set.id
}

module "papc_global_tags_variable_set" {
  source  = "flowingis/variable-set/tfe"
  version = "0.3.1"

  name                    = "papc_global_tags"
  organization            = var.tfe_organization
  terraform_hcl_variables = { global_tags = { purpose = "Terraform Prisma Cloud Demo" } }
}

resource "tfe_project_variable_set" "papc_global_tags" {
  project_id      = module.project.project_id
  variable_set_id = module.papc_global_tags_variable_set.id
}

########################################################################
# common
# 
# module "github-repo-network" {
#   source = "./modules/terraform-github-repo"

#   vcs_repo_name = var.vcs_repo_name
# }

########################################################################
# dev
#
module "github-branch-dev" {
  source = "./modules/terraform-github-branch"

  vcs_repo_name   = module.github-repo.name
  vcs_repo_branch = "dev"
}

module "workspace-dev" {
  source = "./modules/terraform-tfe-tfe_workspace"

  organization        = var.tfe_organization
  project_id          = module.project.project_id
  workspace           = "${var.prefix}-pc-demo-dev"
  vcs_repo_identifier = "${var.vcs_owner}/${module.github-repo.name}"
  vcs_repo_branch     = module.github-branch-dev.branch
  oauth_token_id      = module.oauth_client.oauth_token_id
  hcp_run_task_id     = tfe_organization_run_task.hcp.id
  tfe_team_id         = tfe_team.team.id
  slack_webhook_url   = var.slack_webhook_url
}

module "variables-dev" {
  source  = "app.terraform.io/ykhemani-demo-org/variable/tfe"
  version = "0.0.1"

  workspace_id = module.workspace-dev.workspace_id
  terraform_variables = {
    hcp_packer_image_bucket_name = var.hcp_packer_image_bucket_name
    hcp_packer_image_channel     = var.hcp_packer_image_channel
    prefix                       = var.prefix
    environment                  = "dev"
  }
}

#
########################################################################
# stage
#
module "github-branch-stage" {
  source = "./modules/terraform-github-branch"

  vcs_repo_name   = module.github-repo.name
  vcs_repo_branch = "stage"
}

module "workspace-stage" {
  source = "./modules/terraform-tfe-tfe_workspace"

  organization        = var.tfe_organization
  project_id          = module.project.project_id
  workspace           = "${var.prefix}-pc-demo-stage"
  vcs_repo_identifier = "${var.vcs_owner}/${module.github-repo.name}"
  vcs_repo_branch     = module.github-branch-stage.branch
  oauth_token_id      = module.oauth_client.oauth_token_id
  hcp_run_task_id     = tfe_organization_run_task.hcp.id
  tfe_team_id         = tfe_team.team.id
  slack_webhook_url   = var.slack_webhook_url
}

module "variables-stage" {
  source  = "app.terraform.io/ykhemani-demo-org/variable/tfe"
  version = "0.0.1"

  workspace_id = module.workspace-stage.workspace_id
  terraform_variables = {
    hcp_packer_image_bucket_name = var.hcp_packer_image_bucket_name
    hcp_packer_image_channel     = var.hcp_packer_image_channel
    prefix                       = var.prefix
    environment                  = "stage"
  }
}

#
########################################################################
# prod
#
module "github-branch-prod" {
  source = "./modules/terraform-github-branch"

  vcs_repo_name   = module.github-repo.name
  vcs_repo_branch = "prod"
}

module "workspace-prod" {
  source = "./modules/terraform-tfe-tfe_workspace"

  organization        = var.tfe_organization
  project_id          = module.project.project_id
  workspace           = "${var.prefix}-pc-demo-prod"
  vcs_repo_identifier = "${var.vcs_owner}/${module.github-repo.name}"
  vcs_repo_branch     = module.github-branch-prod.branch
  oauth_token_id      = module.oauth_client.oauth_token_id
  hcp_run_task_id     = tfe_organization_run_task.hcp.id
  tfe_team_id         = tfe_team.team.id
  slack_webhook_url   = var.slack_webhook_url
}

module "variables-prod" {
  source  = "app.terraform.io/ykhemani-demo-org/variable/tfe"
  version = "0.0.1"

  workspace_id = module.workspace-prod.workspace_id
  terraform_variables = {
    hcp_packer_image_bucket_name = var.hcp_packer_image_bucket_name
    hcp_packer_image_channel     = var.hcp_packer_image_channel
    prefix                       = var.prefix
    environment                  = "prod"
  }
}

#
########################################################################
