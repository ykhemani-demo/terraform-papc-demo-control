output "tfe_team_token" {
  value       = tfe_team_token.team_token.token
  sensitive   = true
  description = "Terraform Team Token. Use this when configuring the Run Task in Prisma Cloud."
}

output "repo_html_url" {
  value       = module.github-repo.html_url
  description = "URL for the GitHub repository for our demo environment."
}

output "repo_http_clone_url" {
  value       = module.github-repo.http_clone_url
  description = "URL that can be provided to git clone to clone the repository via HTTPS."
}

output "repo_ssh_clone_url" {
  value       = module.github-repo.ssh_clone_url
  description = "URL that can be provided to git clone to clone the repository via SSH."
}

output "repo_name" {
  value       = module.github-repo.full_name
  description = "Full name of the GitHub repository."
}

output "workspace-dev-url" {
  value       = module.workspace-dev.workspace_url
  description = "Development Workspace URL."
}

output "workspace-stage-url" {
  value       = module.workspace-stage.workspace_url
  description = "Staging Workspace URL."
}

output "workspace-prod-url" {
  value       = module.workspace-prod.workspace_url
  description = "Production Workspace URL."
}
