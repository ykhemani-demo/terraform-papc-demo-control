terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.3"
    }
  }
  required_version = "~> 1.9.0"

}

resource "github_branch" "branch" {
  repository = var.vcs_repo_name
  branch     = var.vcs_repo_branch
}
