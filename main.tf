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
}

resource "tfe_team_access" "team_access_dev" {
  access       = "admin"
  team_id      = tfe_team.team.id
  workspace_id = module.workspace-dev.workspace_id
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
}

resource "tfe_team_access" "team_access_stage" {
  access       = "admin"
  team_id      = tfe_team.team.id
  workspace_id = module.workspace-stage.workspace_id
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
}

resource "tfe_team_access" "team_access_prod" {
  access       = "admin"
  team_id      = tfe_team.team.id
  workspace_id = module.workspace-prod.workspace_id
}

#
########################################################################
