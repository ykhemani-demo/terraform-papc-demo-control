output "tfe_team_token" {
  value     = tfe_team_token.team_token.token
  sensitive = true
}

output "repo_html_url" {
  value = module.github-repo.html_url
}

output "repo_http_clone_url" {
  value = module.github-repo.http_clone_url
}

output "repo_ssh_clone_url" {
  value = module.github-repo.ssh_clone_url
}

output "repo_name" {
  value = module.github-repo.full_name
}

output "workspace-dev-url" {
  value = module.workspace-dev.workspace_url
}

output "workspace-stage-url" {
  value = module.workspace-stage.workspace_url
}

output "workspace-prod-url" {
  value = module.workspace-prod.workspace_url
}
