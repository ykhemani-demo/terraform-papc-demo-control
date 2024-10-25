terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.58"
    }
  }

  required_version = "~> 1.9.0"
}

resource "tfe_policy_set" "policy_set" {
  name          = var.policy_set_name
  organization  = var.tfe_organization
  global        = var.global
  kind          = var.policy_set_kind
  policies_path = var.policies_path
  vcs_repo {
    identifier     = var.policy_set_repo_identifier
    branch         = var.policy_set_repo_branch
    oauth_token_id = var.oauth_token_id
  }
}
