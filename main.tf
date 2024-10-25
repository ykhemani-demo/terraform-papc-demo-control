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
#
module "cloud_agnostic_policy_set" {
  source = "./modules/terraform-tfe-tfe_policy_set"

  policy_set_name            = "cloud_agnostic"
  tfe_organization           = var.tfe_organization
  policies_path              = "cloud-agnostic"
  policy_set_repo_identifier = var.policy_set_repo_identifier
  policy_set_repo_branch     = var.policy_set_repo_branch
  policy_set_kind            = "sentinel"
  global                     = true
  oauth_token_id             = module.oauth_client.oauth_token_id
}

resource "tfe_policy_set_parameter" "cloud_agnostic-organizations" {
  key          = "organizations"
  value        = "[\"${var.tfe_organization}\"]"
  policy_set_id = module.cloud_agnostic_policy_set.policy_set_id
}

module "aws_policy_set" {
  source = "./modules/terraform-tfe-tfe_policy_set"

  policy_set_name            = "aws"
  tfe_organization           = var.tfe_organization
  policies_path              = "aws"
  policy_set_repo_identifier = var.policy_set_repo_identifier
  policy_set_repo_branch     = var.policy_set_repo_branch
  policy_set_kind            = "sentinel"
  global                     = true
  oauth_token_id             = module.oauth_client.oauth_token_id
}

module "azure_policy_set" {
  source = "./modules/terraform-tfe-tfe_policy_set"

  policy_set_name            = "azure"
  tfe_organization           = var.tfe_organization
  policies_path              = "azure"
  policy_set_repo_identifier = var.policy_set_repo_identifier
  policy_set_repo_branch     = var.policy_set_repo_branch
  policy_set_kind            = "sentinel"
  oauth_token_id             = module.oauth_client.oauth_token_id
}

module "gcp_policy_set" {
  source = "./modules/terraform-tfe-tfe_policy_set"

  policy_set_name            = "gcp"
  tfe_organization           = var.tfe_organization
  policies_path              = "gcp"
  policy_set_repo_identifier = var.policy_set_repo_identifier
  policy_set_repo_branch     = var.policy_set_repo_branch
  policy_set_kind            = "sentinel"
  oauth_token_id             = module.oauth_client.oauth_token_id
}
#
########################################################################
#
resource "tfe_agent_pool" "agent_pool" {
  count               = var.tfe_agent_pool_name != "" ? 1 : 0
  name                = var.tfe_agent_pool_name
  organization        = var.tfe_organization
  organization_scoped = var.tfe_agent_organization_scoped
}

resource "tfe_agent_token" "agent_token" {
  count         = var.tfe_agent_pool_name != "" ? 1 : 0
  agent_pool_id = tfe_agent_pool.agent_pool[count.index].id
  description   = "${var.prefix}-${var.tfe_agent_pool_name}-token"
}
#
########################################################################
#
module "github-repo-app" {
  source = "./modules/terraform-github-repo"

  repo_name        = var.repo_name
  repo_description = var.repo_description
  repo_visibility  = var.repo_visibility
}

resource "github_repository_file" "gitignore" {
  repository     = module.github-repo-app.name
  branch         = "main"
  file           = ".gitignore"
  content        = file("${path.module}/demo-repo/.gitignore")
  commit_message = "Managed by Terraform"
}

resource "github_repository_file" "tf0" {
  repository     = module.github-repo-app.name
  branch         = "main"
  file           = "0.tf"
  content        = file("${path.module}/demo-repo/0.tf")
  commit_message = "Managed by Terraform"
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

  name                    = "${var.prefix}_global_tags"
  organization            = var.tfe_organization
  terraform_hcl_variables = { global_tags = { purpose = "HCP Terraform Demo" } }
}

resource "tfe_project_variable_set" "papc_global_tags" {
  project_id      = module.project.project_id
  variable_set_id = module.papc_global_tags_variable_set.id
}

########################################################################
# common - vpc
module "github-repo-common" {
  source = "./modules/terraform-github-repo"

  repo_name        = "${var.repo_name}-common"
  repo_description = var.repo_description
  repo_visibility  = var.repo_visibility
}

resource "github_repository_file" "gitignore-common" {
  repository     = module.github-repo-common.name
  branch         = "main"
  file           = ".gitignore"
  content        = file("${path.module}/demo-repo/.gitignore")
  commit_message = "Managed by Terraform"
}

resource "github_repository_file" "vpc" {
  repository     = module.github-repo-common.name
  branch         = "main"
  file           = "vpc.tf"
  content        = file("${path.module}/demo-repo/vpc/vpc.tf")
  commit_message = "Managed by Terraform"
}

module "workspace-common" {
  source = "./modules/terraform-tfe-tfe_workspace"

  depends_on = [
    github_repository_file.gitignore-common,
    github_repository_file.vpc
  ]

  organization        = var.tfe_organization
  project_id          = module.project.project_id
  workspace           = "${var.prefix}-demo-common"
  vcs_repo_identifier = "${var.vcs_owner}/${module.github-repo-common.name}"
  vcs_repo_branch     = "main"
  oauth_token_id      = module.oauth_client.oauth_token_id
  hcp_run_task_id     = tfe_organization_run_task.hcp.id
  tfe_team_id         = tfe_team.team.id
  slack_webhook_url   = var.slack_webhook_url
  global_remote_state = true
}

module "variables-common" {
  source  = "app.terraform.io/ykhemani-demo-org/variable/tfe"
  version = "0.0.1"

  workspace_id = module.workspace-common.workspace_id
  terraform_variables = {
    prefix = var.prefix
  }
}

########################################################################
# dev
#
module "github-branch-dev" {
  source = "./modules/terraform-github-branch"

  depends_on = [
    github_repository_file.gitignore,
    github_repository_file.tf0
  ]

  vcs_repo_name   = module.github-repo-app.name
  vcs_repo_branch = "dev"
}

module "workspace-dev" {
  source = "./modules/terraform-tfe-tfe_workspace"

  organization        = var.tfe_organization
  project_id          = module.project.project_id
  workspace           = "${var.prefix}-demo-dev"
  vcs_repo_identifier = "${var.vcs_owner}/${module.github-repo-app.name}"
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
    tfe_organization             = var.tfe_organization
    workspace_common             = "${var.prefix}-demo-common"
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

  depends_on = [
    github_repository_file.gitignore,
    github_repository_file.tf0
  ]

  vcs_repo_name   = module.github-repo-app.name
  vcs_repo_branch = "stage"
}

module "workspace-stage" {
  source = "./modules/terraform-tfe-tfe_workspace"

  organization        = var.tfe_organization
  project_id          = module.project.project_id
  workspace           = "${var.prefix}-demo-stage"
  vcs_repo_identifier = "${var.vcs_owner}/${module.github-repo-app.name}"
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
    tfe_organization             = var.tfe_organization
    workspace_common             = "${var.prefix}-demo-common"
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

  depends_on = [
    github_repository_file.gitignore,
    github_repository_file.tf0
  ]

  vcs_repo_name   = module.github-repo-app.name
  vcs_repo_branch = "prod"
}

module "workspace-prod" {
  source = "./modules/terraform-tfe-tfe_workspace"

  organization        = var.tfe_organization
  project_id          = module.project.project_id
  workspace           = "${var.prefix}-demo-prod"
  vcs_repo_identifier = "${var.vcs_owner}/${module.github-repo-app.name}"
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
    tfe_organization             = var.tfe_organization
    workspace_common             = "${var.prefix}-demo-common"
    hcp_packer_image_bucket_name = var.hcp_packer_image_bucket_name
    hcp_packer_image_channel     = var.hcp_packer_image_channel
    prefix                       = var.prefix
    environment                  = "prod"
  }
}

#
########################################################################
