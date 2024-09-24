terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.58"
    }
  }

  required_version = "~> 1.9.0"
}

resource "tfe_workspace" "workspace" {
  name                           = var.workspace
  organization                   = var.organization
  allow_destroy_plan             = var.allow_destroy_plan
  assessments_enabled            = var.assessments_enabled
  auto_apply                     = var.auto_apply
  auto_destroy_activity_duration = var.auto_destroy_activity_duration
  description                    = var.description
  project_id                     = var.project_id
  vcs_repo {
    identifier     = var.vcs_repo_identifier
    branch         = var.vcs_repo_branch
    oauth_token_id = var.oauth_token_id
  }
}

resource "tfe_workspace_run_task" "hcp-run-task" {
  workspace_id = tfe_workspace.workspace.id
  task_id = var.hcp_run_task_id
  enforcement_level = "mandatory"
  stages = ["post_plan"]
}

resource "tfe_team_access" "team_access" {
  access       = var.tfe_team_access
  team_id      = var.tfe_team_id
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_notification_configuration" "slack" {
  name             = tfe_workspace.workspace.name
  enabled          = true
  destination_type = "slack"
  url              = var.slack_webhook_url
  workspace_id     = tfe_workspace.workspace.id
}
