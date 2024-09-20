terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.3"
    }
  }
  required_version = "~> 1.9.0"

}

resource "github_repository" "repo" {
  name       = var.vcs_repo_name
  visibility = var.repo_visibility
  auto_init  = true
}

#resource "github_repository_file" "readme" {
#  repository        = github_repository.repo.name
#  branch            = "teraform"
#  file              = "README.md"
#  content           = "# Managed by Terraform"
#  commit_message    = "Managed by Terraform"
#  autocreate_branch = true
#}
